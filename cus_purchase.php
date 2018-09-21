<?php 
	$title="Add product transaction information";
	include 'cus_head.php';
?>
<?php 
  require_once('conn.php');
  $pid = $_GET['pid'];
   $cid = $_GET['cid'];
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
			<h3>Product Name： <?php echo $pname; ?></h3>
			<h3>Original Price： <?php echo $product['original_price']; ?></h3>
			<h3>
Discount： <?php echo $product['discnt_rate']; ?></h3>
			
			
                        <form id="form1" class="form-inline"  method="post" action="cus_purchase_handle.php">               
			  <input type="hidden" name="pid" value=<?php echo $pid; ?>>  
                           <input type="hidden" name="cid" value=<?php echo $cid; ?>>  
              
			  <br>	
			  <br>	
			  
                          <br>
			  <div class="form-group">
				<label>Purchase quantity</label>
				<input type="text" class="form-control" id="qty" name="qty" onkeyup="CountMoney(this.value,<?php echo $product['original_price'] - ($product['discnt_rate']); ?>)"/>
   			  </div>

			<h3>
A total of payment：<span id="totalprice">0</span> Rs</h3>
	        <br>
	        <button class="btn btn-primary" id="submit1">Add to Cart</button>
			
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
<br>
<br>
<br>
<br><br>
<br><br>
<br>
<?php include 'footer.php'; ?>
