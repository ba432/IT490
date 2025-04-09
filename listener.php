<?php
require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

// Database connection
$host = 'localhost';
$dbname = 'IT490';
$user = 'IT490';
$pass = 'password';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed.");
}

// RabbitMQ connection
$connection = new AMQPStreamConnection('localhost', 5672, 'guest', 'guest');
$channel = $connection->channel();

// Declare queues
$channel->queue_declare('registration', false, true, false, false);
$channel->queue_declare('login', false, true, false, false);
$channel->queue_declare('movies_search', false, true, false, false);
$channel->queue_declare('omdb_fetch', false, true, false, false);
$channel->queue_declare('movie_favorite', false, true, false, false);

$callback = function ($msg) use ($pdo, $channel) {
    $data = json_decode($msg->body, true);
    $response = [];
    
    try {
        switch ($msg->get('routing_key')) {
            case 'registration':
                $stmt = $pdo->prepare("INSERT INTO users (username, password_hash) VALUES (?, ?)");
                $stmt->execute([$data['username'], password_hash($data['password'], PASSWORD_BCRYPT)]);
                $response = ['success' => true, 'message' => "User registered"];
                break;
                
            case 'login':
                $stmt = $pdo->prepare("SELECT id, password_hash FROM users WHERE username = ?");
                $stmt->execute([$data['username']]);
                $user = $stmt->fetch();

                if ($user && password_verify($data['password'], $user['password_hash'])) {
                    $sessionKey = bin2hex(random_bytes(16));
                    $stmt = $pdo->prepare("INSERT INTO sessions (user_id, session_key, expires_at) VALUES (?, ?, ?)");
                    $stmt->execute([
                        $user['id'],
                        $sessionKey,
                        (new DateTime('+1 hour'))->format('Y-m-d H:i:s')
                    ]);
                    $response = ['success' => true, 'user_id' => $user['id'], 'session_key' => $sessionKey];
                } else {
                    $response = ['success' => false];
                }
                break;

            case 'movies_search':
                $stmt = $pdo->prepare("SELECT * FROM movies WHERE user_id = ? AND movie_title LIKE ?");
                $stmt->execute([$data['user_id'], '%' . $data['search'] . '%']);
                $movies = $stmt->fetchAll(PDO::FETCH_ASSOC);
                $response = ['success' => true, 'movies' => $movies];
                break;

            case 'omdb_fetch':
                $apiKey = '9cf7c4c9';
                $url = "http://www.omdbapi.com/?s={$data['search']}&apikey=$apiKey";
                $omdbData = json_decode(file_get_contents($url), true);
                
                if ($omdbData['Response'] === 'True') {
                    foreach ($omdbData['Search'] as $movie) {
                        $stmt = $pdo->prepare(
                            "INSERT INTO movies 
                            (user_id, movie_title, year, imdb_id, poster_url) 
                            VALUES (?, ?, ?, ?, ?)
                            ON DUPLICATE KEY UPDATE last_searched = NOW()"
                        );
                        $stmt->execute([
                            $data['user_id'],
                            $movie['Title'],
                            $movie['Year'],
                            $movie['imdbID'],
                            $movie['Poster']
                        ]);
                    }
                    $response = ['success' => true, 'count' => count($omdbData['Search'])];
                } else {
                    $response = ['success' => false, 'error' => $omdbData['Error']];
                }
                break;

            case 'movie_favorite':
                $stmt = $pdo->prepare(
                    "UPDATE movies SET is_favorite = ? 
                    WHERE id = ? AND user_id = ?"
                );
                $stmt->execute([$data['set_favorite'], $data['movie_id'], $data['user_id']]);
                $response = ['success' => true];
                break;

            default:
                throw new Exception("Unknown queue");
        }
    } catch (Exception $e) {
        $response = ['success' => false, 'error' => $e->getMessage()];
    }

    $replyMsg = new AMQPMessage(
        json_encode($response),
        ['correlation_id' => $msg->get('correlation_id')]
    );
    $channel->basic_publish($replyMsg, '', $msg->get('reply_to'));
};

// Consume messages
$channel->basic_consume('registration', '', false, true, false, false, $callback);
$channel->basic_consume('login', '', false, true, false, false, $callback);
$channel->basic_consume('movies_search', '', false, true, false, false, $callback);
$channel->basic_consume('omdb_fetch', '', false, true, false, false, $callback);
$channel->basic_consume('movie_favorite', '', false, true, false, false, $callback);

while ($channel->is_consuming()) {
    $channel->wait();
}

$channel->close();
$connection->close();
?>