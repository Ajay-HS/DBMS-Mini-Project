<?php 
	$title="Trading Information";
	include 'head.php';
?>

<table class="table table-condensed">
   <div>
  
   <thead>
     <div class="page-header">
   <h2>Purchases</h2>
   </div>
    </div>
      <tr>
         <th>Commodity transaction number</th><th>
Customer Number</th><th>Employee ID</th><th>Product Id</th><th>
Purchase quantity of goods</th><th>Transaction hour</th><th>
Total price of goods</th>
      </tr>
   </thead>
   <?php 
error_reporting(0);
require_once('conn.php');

$query = "call show_purchases()"; 
$res = mysql_query($query) or die(mysql_error());
$row = mysql_num_rows($res);   
if($row)
{
for($i=0;$i<$row;$i++)          
{ 
$dbrow=mysql_fetch_array($res);
$purid=$dbrow['purid']; 
$cid=$dbrow['cid']; 
$eid=$dbrow['eid'];  
$pid=$dbrow['pid'];
$qty=$dbrow['qty'];
$ptime=$dbrow['ptime'];
$total_price=$dbrow['total_price'];  
echo"<tr>
<td>".$purid."</td>
<td>".$cid."</td>
<td>".$eid."</td>
<td>".$pid."</td>
<td>".$qty."</td>
<td>".$ptime."</td>
<td>".$total_price."</td>
</tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>