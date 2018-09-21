<?php 
  $title="Home";
  include 'head.php';
?>

  
  
  <div class="row">
<center>
      <!-- end div#content --><!-- end div#sidebar -->
      <?php
//include("header.php");
extract($_POST);

include("conn.php");

if($_POST['cname'] =='' ||$_POST['pass']==''||$_POST['city']==''){
echo "<script type='text/javascript'>alert('Please enter a valid customer detail'); window.location.href='customerreg.php'; </script>";	
}else{
$query="insert into customers(cname,city,password) values('$cname','$city','$pass')";
$rs=mysql_query($query)  or die(mysql_error());
echo "<br><br><br><div class=head1>Customer Registered Sucessfully</div>";
//echo  'inserted';
echo "<script type='text/javascript'>alert('Customer Registered Sucessfully'); window.location.href='first.php'; </script>";		
}

?>
      </center>
    
  </div>  

<?php include 'footer.php'; ?>