<?php
require_once __DIR__ . '/vendor/autoload.php';
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

define('RABBITMQ_HOST', 'localhost');
define('RABBITMQ_PORT', 5672);
define('RABBITMQ_USER', 'guest');
define('RABBITMQ_PASS', 'guest');
define('QUEUE_NAME', 'login');

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
            'username' => $username,
            'password' => $password
        ];
    
        sendToQueue($message);
        $success = "Login request sent. Please wait...";
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
	<div class="login_form">
		<form method="post">
			<h2 class="login">Login</h2>
			<?php if (isset($error)) echo "<p style='color: red;'>$error</p>"; ?>
    	    		<?php if (isset($success)) echo "<p style='color: green;'>$success</p>"; ?>
			<div>
				<div class="input_box">
					<label for="email">Username</label>
					<input type="text" id="username" name="username" required />
				</div>
				<div class="input_box">
					<div>
						<label for="password">Password</label>
					</div>
					<input type="password" id="password" name="password" required />
				</div>
				<button type="submit">Log In</button>
				<p class="sign_up">Don't have an account? <a href="register.html">Sign up</a></p>
		</form>
	</div>
</body>

</html>
