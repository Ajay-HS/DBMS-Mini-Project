<?php 
$hostname = "localhost"; 
$database = "rbms"; 
$username = "root"; 
$password = "";
$conn = @mysql_connect($hostname, $username, $password) or trigger_error(mysql_error() , E_USER_ERROR); 
mysql_select_db($database, $conn); 
$db = @mysql_select_db($database, $conn) or die(mysql_error());
$encode = @mysql_query('set names utf8') or die(mysql_error());
?> 
