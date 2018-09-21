<?php 
	$title="Customer Information";
	include 'head.php';
?>
  
<table class="table table-condensed">
   <div>
  
   <thead>
   <div class="page-header">
   <h2>Customers</h2>
   </div>
    </div>
      <tr>
         <th>Customer Number</th><th>Customer Name</th><th>City</th><th>Visits</th><th>Last visit time</th>
      </tr>
   </thead>
   <?php 
error_reporting(0);
require_once('conn.php');
$query = "select cid,cname,city,visits_made,last_visit_time from customers";  
$res = mysql_query($query, $conn) or die(mysql_error());
$row = mysql_num_rows($res); 
if($row)
{
for($i=0;$i<$row;$i++)    
{ 
$dbrow=mysql_fetch_array($res);
$cid=$dbrow['cid']; 
$cname=$dbrow['cname']; 
$city=$dbrow['city'];  
$visits_time=$dbrow['visits_made']; 
$last_visit_time=$dbrow['last_visit_time'];  
echo"<tr>
<td>".$cid."</td>
<td>".$cname."</td>
<td>".$city."</td>
<td>".$visits_time."</td>
<td>".$last_visit_time."</td>
</tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>