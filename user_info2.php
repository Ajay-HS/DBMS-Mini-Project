
<?php 
  $title="Home";
  include 'cus_head.php';
?>

  
  
  <div class="row">
<center>
  
      </center>
    
  </div>  
<?php
echo "Thanks For Purchasing.... The Products will be delivered soon";

	include "conn.php";
	
	$id1=$_POST['cid'];
	
	mysql_query("delete from cart where c_name=$id1");
	

	
	mysql_query("update customers set visits_made = visits_made + 1,last_visit_time = new.ptime where cid =$id1");
	echo "<script type='text/javascript'>window.location.href='first.php'; alert('Thanks For Purchasing.... The Products will be delivered soon'');</script>";
	//header("location:first.php");

?>
<?php include 'footer.php'; ?>

     