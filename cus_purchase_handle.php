<?php 
  $title="Order processing";
  include 'cus_head.php';
?>

<?php 
  require_once('conn.php');
  $cid = $_POST['cid'];
  $eid =0;
  $pid = $_POST['pid'];
  $qty = $_POST['qty'];
  
  $errors = [];
  if(empty($qty)) $errors[] = "Please enter the purchase number！";
  else{
      $sql1 = "select qoh, qoh_threshold from products where pid = $pid";
      // $sql1 = "call get_product_qty($pid)";
      $query1 = mysql_query($sql1) or die(mysql_error());
      if($query1 && mysql_num_rows($query1)){
        $qoh_e = mysql_fetch_assoc($query1);
        $qoh = $qoh_e['qoh'];
		$qoh_threshold = $qoh_e['qoh_threshold'];
        if($qoh<=$qty){
            $errors[] = "Inventory is less than the purchase quantity! please enter again";
        }
		elseif ($qoh_threshold < $qty){
			$errors[] = "Maximu limit for this product is : $qoh_threshold Please enter less than that";
		}
		else{
            $sql = "call add_purchase($cid,$eid,$pid,$qty);";
            $query = mysql_query($sql) or die(mysql_error());
            if(gettype($query) == 'resource'){
                $back = true;
                if($query&&mysql_num_rows($query)){
                  while($row = mysql_fetch_assoc($query)){
                    $data[] = $row;
                  }
                }
                $old_qoh = $data[0]['old_qoh'];
                $increased = $data[0]['old_plus_sold'];
                //if(isset($data)) var_dump($data);
                
                
              
            }else if(gettype($query) == 'boolean'){
                
                  //get price
                $rate=null;
                $SQL = "SELECT * FROM `products` WHERE pid='$pid'";	
	//$result = mysql_query($SQL);
        $result=mysql_query($SQL)  or die(mysql_error());
$count=mysql_num_rows($result);
while($row=mysql_fetch_array($result))
{
	$rate=$row[4]-$row[5];
}
                //ADD TO CART
              	
				$q3="insert into cart(c_name,p_name,price,quantity) values('$cid','$pid',$rate,$qty)";
				 $res=mysql_query($q3)  or die(mysql_error());
				//mysql_query($q3);
				//echo $q3;
				echo "<script type='text/javascript'>alert('Added to Cart');  </script>";
                
                
                
              $back = false; 
              
            }
        }
      }
  }
  
?>
  <ol class="breadcrumb">
    <li><a>Order</a></li>
    <li><a>cart</a></li>
  </ol>

  <div class="row-fluid">

		<div class="col-md-9">
      <?php 
        if(!empty($errors)){
          echo '<div class="alert alert-danger" role="alert">Failed purchase！</div>';
          foreach ($errors as $error) {
            echo '<p class="text-danger">'.$error.'</p>';   
          }
        }
        else{
          echo '<div class="alert alert-success" role="alert">Added to cart！</div>';
          
        }
       ?>
    <a href="cus_index.php?cid=<?php echo $cid;?>" >[ Continue Shopping ]</a> <a href="cart_list.php?cid=<?php echo $cid; ?>">[ My Cart ]</a>
		</div>
		<div class="col-md-3">
			
		</div>
	</div>

<?php include 'footer.php'; ?>
