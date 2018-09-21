<?php 
	$title="employee information";
	include 'head.php';
?>
<table class="table table-condensed">
   <div>
  
   <thead>
     <div class="page-header">
   <h2>Employees</h2>
   </div>
        </div>
      <tr>
         <th>Employee ID</th><th>Employee's name</th><th>City</th>
      </tr>
   </thead>
   <?php 
error_reporting(0);
require_once('conn.php');
$query = "call show_employees();";  
$res = mysql_query($query, $conn) or die(mysql_error());
$row = mysql_num_rows($res);
if($row)
{
for($i=0;$i<$row;$i++)  
{ 
$dbrow=mysql_fetch_array($res);
$eid=$dbrow['eid']; $ename=$dbrow['ename']; $city=$dbrow['city'];  
echo"<tr>
<td>".$eid."</td><td>".$ename."</td><td>".$city."</td>
</tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>