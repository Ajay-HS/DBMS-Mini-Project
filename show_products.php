<?php 
	$title="Product Information";
	include 'head.php';
?>
<table class="table table-condensed">
   <div>
  
   <thead>
    <div class="page-header">
   <h2>Products</h2>
   </div>
    </div>
      <tr>
         <th>Product Number</th><th>Product name</th><th>Total inventory</th><th>Threshold</th><th>Product price</th><th>Product discount rate</th><th>
Supplier code</th>
      </tr>
   </thead>
   <?php 
error_reporting(0);
require_once("conn.php");
$query = "select pid,pname,qoh,qoh_threshold,original_price,discnt_rate,sid from products";  
$res = mysql_query($query, $conn) or die(mysql_error());
$row = mysql_num_rows($res);  
if($row)
{
for($i=0;$i<$row;$i++)         
{ 
$dbrow=mysql_fetch_array($res);
$pid=$dbrow['pid']; 
$pname=$dbrow['pname']; 
$qoh=$dbrow['qoh']; 
$qoh_threshold=$dbrow['qoh_threshold'];  
$original_price=$dbrow['original_price']; 
$discnt_rate=$dbrow['discnt_rate'];
$sid=$dbrow['sid'];
 
echo"<tr>
<td>".$pid."</td>
<td>".$pname."</td>
<td>".$qoh."</td>
<td>".$qoh_threshold."</td>
<td>".$original_price."</td>
<td>".$discnt_rate."</td>
<td>".$sid."</td>
</tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>