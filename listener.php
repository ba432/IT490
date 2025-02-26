#Look at why we need autoload for this to work
#Install 

<?php
require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

// Logging setup
$log = new Logger('listener');
$log->pushHandler(new StreamHandler(__DIR__ . '/listener.log', Logger::INFO));

// Database connection
$host = 'localhost';
$dbname = 'auth_system';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// RabbitMQ connection
try {
    $connection = new AMQPStreamConnection('rabbitmq', 5672, 'myuser', 'mypassword');
    $channel = $connection->channel();
    $channel->queue_declare('registration', false, true, false, false);
    $channel->queue_declare('login', false, true, false, false);
} catch (Exception $e) {
    die("RabbitMQ connection failed: " . $e->getMessage());
}

echo "Waiting for messages...\n";

$callback = function ($msg) use ($pdo, $log) {
    $data = json_decode($msg->body, true);

    if ($msg->delivery_info['routing_key'] === 'registration') {
        // Handle registration
        $hashedPassword = password_hash($data['password'], PASSWORD_DEFAULT);
        $stmt = $pdo->prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
        $stmt->execute(['username' => $data['username'], 'password' => $hashedPassword]);
        $log->info("User registered: " . $data['username']);
    } elseif ($msg->delivery_info['routing_key'] === 'login') {
        // Handle login
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
        $stmt->execute(['username' => $data['username']]);
        $user = $stmt->fetch();

        if ($user && password_verify($data['password'], $user['password'])) {
            $sessionKey = bin2hex(random_bytes(16));
            $stmt = $pdo->prepare("UPDATE users SET session_key = :session_key WHERE id = :id");
            $stmt->execute(['session_key' => $sessionKey, 'id' => $user['id']]);
            $log->info("Login successful: " . $data['username']);
        } else {
            $log->error("Login failed: " . $data['username']);
        }
    }
};

$channel->basic_consume('registration', '', false, true, false, false, $callback);
$channel->basic_consume('login', '', false, true, false, false, $callback);

// Graceful shutdown
declare(ticks=1);
pcntl_signal(SIGINT, function () use ($channel, $connection) {
    echo "Shutting down...\n";
    $channel->close();
    $connection->close();
    exit(0);
});

while ($channel->is_consuming()) {
    $channel->wait();
}

$channel->close();
$connection->close();
