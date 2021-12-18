<?php

session_start();

//Make sure their user/pass is actually correct
if ($_SESSION["username"] === "admin" &&
	sha1($_SESSION["password"] . "15634jghrzatar98@%$GST") === "fc5f7738ff91295fe782319d874ecf3723dde0c8") {
	$descriptors = array(
		0 => array("pipe", "r"),
		1 => array("pipe", "w"),
		2 => array("pipe", "w")
	);

	$command = "sudo /var/www/stop-server.sh";
	$process = proc_open($command, $descriptors, $pipes);

	if (is_resource($process)) {
		echo(stream_get_contents($pipes[1]));
		$return = proc_close($process);

		if ($return == 0) {
			echo(json_encode(array("success" => true)));
		} else {
			echo(json_encode(array("success" => false)));
		}
	} else {
		echo(json_encode(array("success" => false)));
	}
} else {
	echo(json_encode(array("success" => false)));
}