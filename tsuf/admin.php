<?php

session_start();

if (array_key_exists("password", $_POST)) {
	$_SESSION["username"] = $_POST["username"];
	$_SESSION["password"] = $_POST["password"];
}

//Make sure their user/pass is actually correct
if ($_SESSION["username"] === "admin" &&
	sha1($_SESSION["password"] . "15634jghrzatar98@%") === "fc5f7738ff91295fe782319d874ecf3723dde0c8") {
?>

<html>
<head>
	<title>Tsuf Admin Page</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

function detectServer() {
	$.ajax({
		url: "detect-server.php",
		dataType: "json"
	}).done(function (data) {
		$("#running").text(data.status ? "Yes, (PID " + data.pid + ")" : "No");
		$("#start-server").attr("disabled", (data.status ? "disabled" : null));
		$("#stop-server").attr("disabled", (!data.status ? "disabled" : null));
	}).fail(function () {
		alert("Failure");
	});
	$("#running").text("Loading...");
}	

function startServer() {
	$.ajax({
		url: "start-server.php",
		dataType: "json"
	}).done(function (data) {
		alert(data.success ? "Success" : "Failure");
	}).fail(function () {
		alert("Failure");
	}).always(function() {
		detectServer();
	});

	$("#start-server").attr("disabled", "disabled");
	$("#stop-server").attr("disabled", "disabled");
}	

function stopServer() {
	$.ajax({
		url: "stop-server.php",
		dataType: "json"
	}).done(function (data) {
		alert(data.success ? "Success" : "Failure");
	}).fail(function () {
		alert("Failure");
	}).always(function () {
		detectServer();
	});

	$("#start-server").attr("disabled", "disabled");
	$("#stop-server").attr("disabled", "disabled");
}
function fetchConsole() {
	$.ajax({
		url: "console.log.php",
		dataType: "text"
	}).done(function (data) {
		var con = $("#console");
		con.text(data);
		con.scrollTop(con[0].scrollHeight);
	});
}

	</script>
</head>
<body>
	Running: <span id="running">Unknown</span><button onclick="detectServer();">Update</button><br>
	<button id="start-server" onclick="startServer();" disabled="disabled">Start it</button><br>
	<button id="stop-server" onclick="stopServer();" disabled="disabled">Stop it</button><br>
	Console: <button id="fetch-console" onclick="fetchConsole();">Fetch</button><br>
	<pre id="console" style="overflow-y: scroll; height: calc(100% - 120px);">

	</pre>
	<script type="text/javascript">
		detectServer();
		setInterval(detectServer, 30000);
	</script>
</body>
</html>
<?php
} else {
	header("Location: index.php?fail=true");
}
?>
