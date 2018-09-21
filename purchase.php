<?php 
	$title="Add product transaction information";
	include 'head.php';
?>
<?php 
  require_once('conn.php');
  $pid = $_GET['pid'];
  $sql2 = "select * from customers";
  $query2 = mysql_query($sql2) or die(mysql_error());
  if($query2 && @mysql_num_rows($query2)){
    while($row = mysql_fetch_assoc($query2)){
      $customers[] = $row;
    }
  }

  $sql3 = "select * from employees";
  $query3 = mysql_query($sql3) or die(mysql_error());
  if($query3&&mysql_num_rows($query3)){
    while($row = mysql_fetch_assoc($query3)){
      $employees[] = $row;
    }
  }
  $sql1 = "call find_product($pid);";
  $query1 = mysql_query($sql1) or die(mysql_error());
  if($query1&&mysql_num_rows($query1)){
  	while($row = mysql_fetch_assoc($query1)){
      $products[] = $row;
    }
	$product = $products[0];
    $pname = $product['pname'];
    $imgname = $product['imgname'];
    $imgname = $imgname? $imgname : 'no-image.png'; 
  }
?>

	<ol class="breadcrumb">
		<li>Product</li>
		<li>
Buy</li>
		<li><a><?php echo $pname; ?></a></li>
	</ol>
	<div class="row-fluid">
		

		<div class="col-md-7">
			<legend>Purchase list</legend> 
			<h3>Product name： <?php echo $pname; ?></h3>
			<h3>Original price： <?php echo $product['original_price']; ?></h3>
			<h3>
Discount： <?php echo $product['discnt_rate']; ?></h3>
			<h3>In stock： <?php echo $product['qoh']; ?></h3>
			
			<form id="form1" class="form-inline"  method="post" action="purchase_handle.php">               
			  <input type="hidden" name="pid" value=<?php echo $pid; ?>>  
              <div class="form-group">     
					<label>
Operate staff(employee):</label>
					<?php 
					  if(!isset($employees)) echo "<h3>No staff, please add first</h3>";
					  else{
					  	echo '<select name="eid" class="form-control">';
					    foreach ($employees as $employee) {
					?>
					
				        <option value="<?php echo $employee['eid']; ?>"><?php echo $employee['eid'].'.'.$employee['ename']; ?></option>
				    <?php 
				    	
				    	}
				    	echo "</select>";
					} 

				    ?>
			      	
			  </div>
			  <br>	
			  <div class="form-group">     
					 <input type="hidden" name="cid" value="0">  
			  </div>
			  <div class="form-group">
				<label>Purchase quantity</label>
				<input type="text" class="form-control" id="qty" name="qty" onkeyup="CountMoney(this.value,<?php echo $product['original_price'] - ($product['discnt_rate']); ?>)"/>
   			  
                          </div>

			<h3>
A total of payment：<span id="totalprice">0</span> Rs</h3>
	        <br>
	        <button class="btn btn-primary" id="submit1">Submit</button>
			
		 </form>
		</div>
		<div class="col-md-3">
			<img src="img/<?php echo $imgname; ?>" alt="140x140" width="232" height="230" class="img-polaroid" />
		</div>
	</div>
<script type="text/javascript"> 
    function CountMoney(qty,price){
        var total = qty * price;
        document.getElementById("totalprice").innerHTML = total;
    }
</script>

<?php include 'footer.php'; ?>
