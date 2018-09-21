<?php
	require_once('conn.php');
	$pid = $_GET['pid'];
	$deletesql = "call del_product($pid);";
	if(mysql_query($deletesql)){
		echo "<script>alert('successfully deleted');window.location.href='index.php';</script>";
	}else{
		echo "<script>alert('failed to delete');window.location.href='index.php';</script>";
	}