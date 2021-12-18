<html>
<head>
	<title>Tsuf Admin Control</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<style type="text/css">
		html, body {
			width: 100%;
			height: 100%;
		}
		.main {
			left: 50%;
			top: 50%;
			position: absolute;

			margin-left: -150px;
			margin-top: -150px;

			width: 300px;
			height: 200px;
		}
		label {
			float: left;
			width: 100%;
		}
		input {
			float: right;
		}
	</style>
</head>
<body>
	<div class="main">
		<h1>Please log in</h1>
		<?php
		if ($_GET["fail"] === "true") { ?>
		<h2>Login failed.</h2>
		<?php } ?>
		<form action="admin.php" method="POST">
			<label for="username">Username: <input name="username" type="text"></label><br>
			<label for="password">Password: <input name="password" type="password"></label><br>
			<label for="submit"><input class="btn btn-success" name="submit" type="submit"></label>
		</form>
	</div>
</body>
</html>
