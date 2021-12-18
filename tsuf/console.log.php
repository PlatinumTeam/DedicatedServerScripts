<?php
ob_start("ob_gzhandler");
readfile("/home/marbleblast/pq/console.log");
