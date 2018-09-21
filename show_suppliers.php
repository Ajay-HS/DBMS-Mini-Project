<?php 
	$title="Supplier information";
	include 'head.php';
?>
<table class="table table-condensed">
   <div>
  
   <thead>
   <div class="page-header">
   <h2>Suppliers</h2>
   </div>
    </div>
      <tr>
         <th>
Supplier code</th><th>
Supplier name</th><th>
City</th><th>Cellphone number</th>
      </tr>
   </thead>
   <?php 
      error_reporting(0);
      require_once('conn.php');
      $query = "select sid,sname,city,telephone_no from suppliers";  
      $res = mysql_query($query, $conn) or die(mysql_error());
      $row = mysql_num_rows($res); 
      if($row)
      {
      for($i=0;$i<$row;$i++)         
      { 
      $dbrow=mysql_fetch_array($res);
      $sid=$dbrow['sid']; 
      $sname=$dbrow['sname']; 
      $city=$dbrow['city'];  
      $telephone_no=$dbrow['telephone_no']; 
      echo"<tr>
      <td>".$sid."</td>
      <td>".$sname."</td>
      <td>".$city."</td>
      <td>".$telephone_no."</td>

      </tr>";
}
}
?>
  
</table>
<?php include 'footer.php'; ?>