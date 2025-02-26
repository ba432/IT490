#Look at why we need autoload for this to work
#Install 

<?php
require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;

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
$connection = new AMQPStreamConnection('rabbitmq', 5672, 'myuser', 'mypassword');
$channel = $connection->channel();
$channel->queue_declare('registration', false, true, false, false);
$channel->queue_declare('login', false, true, false, false);

echo "Waiting for messages...\n";

$callback = function ($msg) use ($pdo) {
    $data = json_decode($msg->body, true);

    if ($msg->get('routing_key') === 'registration') {
        // Handle registration
        $stmt = $pdo->prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
        $stmt->execute(['username' => $data['username'], 'password' => $data['password']]);
        echo "User registered: " . $data['username'] . "\n";
    } elseif ($msg->get('routing_key') === 'login') {
        // Handle login
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
        $stmt->execute(['username' => $data['username']]);
        $user = $stmt->fetch();

        if ($user && password_verify($data['password'], $user['password'])) {
            $sessionKey = bin2hex(random_bytes(16));
            $stmt = $pdo->prepare("UPDATE users SET session_key = :session_key WHERE id = :id");
            $stmt->execute(['session_key' => $sessionKey, 'id' => $user['id']]);
            echo "Login successful: " . $data['username'] . "\n";
        } else {
            echo "Login failed: " . $data['username'] . "\n";
        }
    }
};

$channel->basic_consume('registration', '', false, true, false, false, $callback);
$channel->basic_consume('login', '', false, true, false, false, $callback);

while ($channel->is_consuming()) {
    $channel->wait();
}

$channel->close();
$connection->close();