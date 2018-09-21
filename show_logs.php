<?php 
	$title="Operation log";
	include 'head.php';
?>
  
<table class="table table-condensed">
   <div>
  
   <thead>
    <div class="page-header">
   <h2>Logs</h2>
   </div>
    </div>
      <tr>
         <th>LogID</th><th>Who</th><th>Time</th><th>Table_Name</th><th>Operation</th><th>Key_Value</th>
      </tr>
   </thead>
   <?php 
error_reporting(0);
require_once('conn.php');
$query = "call show_logs();";  
$res = mysql_query($query) or die(mysql_error());
$row = mysql_num_rows($res);    //If the query returns true here or false, the number of columns
if($row)
{
for($i=0;$i<$row;$i++)       
{ 
$dbrow=mysql_fetch_array($res);
$logid=$dbrow['logid']; 
$who=$dbrow['who']; 
$time=$dbrow['time'];  
$table_name=$dbrow['table_name']; 
$operation=$dbrow['operation'];
$key_value=$dbrow['key_value'];   
echo"<tr>
<td>".$logid."</td>
<td>".$who."</td>
<td>".$time."</td>
<td>".$table_name."</td>
<td>".$operation."</td>
<td>".$key_value."</td>
</tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>