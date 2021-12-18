<?php
ob_start("ob_gzhandler");
readfile("/home/marbleblast/mbp/console.log");