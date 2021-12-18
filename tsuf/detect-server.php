<?php

session_start();

//Make sure their user/pass is actually correct
if ($_SESSION["username"] === "admin" &&
	sha1($_SESSION["password"] . "15634jghrzatar98@%") === "fc5f7738ff91295fe782319d874ecf3723dde0c8") {

	//Check if the process is running
	$ps = exec("ps aux | egrep 'marbleblast.exe' | egrep -v 'wineconsole' | egrep -v 'grep'");

	//If the ps failed, it's not running
	if (strlen($ps) > 1) {
		//Extract the PID from the ps line (should be the second "word" grouped by spaces)
		preg_match("/\S+ +(\S+) .*/", $ps, $matches);
		echo(json_encode(array("status" => true, "pid" => $matches[1])));
	} else {
		echo(json_encode(array("status" => false)));
	}
} else {
	echo(json_encode(array("status" => false)));
}