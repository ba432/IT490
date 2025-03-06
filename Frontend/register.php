<?php
require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

define('RABBITMQ_HOST', 'localhost');
define('RABBITMQ_PORT', 5672);
define('RABBITMQ_USER', 'guest');
define('RABBITMQ_PASS', 'guest');
define('QUEUE_NAME', 'registration');

function sendToQueue($message) {
    $connection = new AMQPStreamConnection(RABBITMQ_HOST, RABBITMQ_PORT, RABBITMQ_USER, RABBITMQ_PASS);
    $channel = $connection->channel();
    
    $channel->queue_declare(QUEUE_NAME, false, true, false, false);

    $msg = new AMQPMessage(json_encode($message), ['delivery_mode' => 2]);
    $channel->basic_publish($msg, '', QUEUE_NAME);

    $channel->close();
    $connection->close();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    if (!$username || !$password) {
        $error = "Username and password are required.";
    } else {
        $message = [
            'action' => 'register',
            'username' => $username,
            'password' => $password
        ];
    
        sendToQueue($message);
        $success = "Registration request sent.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="CSS/styles.css">
</head>

<body>
    <div class="register_form">
        <form method="POST">
            <h2 class="register">Register</h2>
            <?php if (isset($error)) echo "<p style='color: red;'>$error</p>"; ?>
    	    <?php if (isset($success)) echo "<p style='color: green;'>$success</p>"; ?>
            <div>
                <div class="input_box">
                    <label for="username">Username</label>
                    <input type="text" name="username" placeholder="Enter username" required />
                </div>
                <div class="input_box">
                    <div>
                        <label for="password">Password</label>
                    </div>
                    <input type="password" name="password" placeholder="Enter your password" required />
                    <div>
                </div>
                <button type="submit">Register</button>
                <p class="sign_up">Have an account? <a href="login.php">Sign in</a></p>
        </form>
</body>

</html>
