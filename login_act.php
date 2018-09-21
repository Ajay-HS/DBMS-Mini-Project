
<?php 
  $title="Home";
  include 'cus_head.php';
?>

  
  
  <div class="row">
<center>
<?php
include("conn.php");
$errflag=FALSE;
// username and password sent from form
$id=$_POST['lid'];
$pass=$_POST['pass']; 
$user=$_POST['user'];

	if($user=="Admin" && $id=="Admin" && $pass=="Admin")
	{
		$wel = "WELCOME: $user";
echo "<script type='text/javascript'>window.location.href='index.php'; alert('{$wel}');</script>";	

	}
	
	elseif($user=="user")
	{
	$SQL = "SELECT * FROM `customers` WHERE cname='$id' AND password='$pass'";	
	$result = mysql_query($SQL);
$count=mysql_num_rows($result);
while($row=mysql_fetch_array($result))
{
    $cid=$row[0];
	$nm=$row[1];
}
// If result matched $myusername and $mypassword, table row must be 1 row
if($count==1){


$wel = "WELCOME: $nm";
//echo "<script type='text/javascript'>alert('{$wel}'); window.location.href='cus_index.php'; </script>";	
?>
<a href="cus_index.php?cid=<?php echo $cid; ?>">Proceed to Shopping</a>.........
<?php
}

 else {
    
echo "<script type='text/javascript'>alert('Wrong Username or Password'); window.location.href='first.php'; </script>";
$errflag=TRUE; 
 }
 }
session_write_close();
ob_end_flush();
?>
      </center>
    
  </div>  

<?php include 'footer.php'; ?>