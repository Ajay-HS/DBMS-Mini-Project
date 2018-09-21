<?php 
  $title="Order processing";
  include 'head.php';
?>

<?php 
  require_once('conn.php');
  $cid = $_POST['cid'];
  $eid = $_POST['eid'];
  $pid = $_POST['pid'];
  $qty = $_POST['qty'];
  
  $errors = [];
  if(empty($qty)) $errors[] = "Please enter the purchase number！";
  else{
      $sql1 = "select qoh from products where pid = $pid";
      // $sql1 = "call get_product_qty($pid)";
      $query1 = mysql_query($sql1) or die(mysql_error());
      if($query1 && mysql_num_rows($query1)){
        $qoh_e = mysql_fetch_assoc($query1);
        $qoh = $qoh_e['qoh'];
        if($qoh<=$qty){
            $errors[] = "Inventory is less than the purchase quantity! please enter again";
        }else{
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
              $back = false; 
            }
        }
      }
  }
  
?>
  <ol class="breadcrumb">
    <li><a>Order</a></li>
    <li><a>process result</a></li>
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
          echo '<div class="alert alert-success" role="alert">The purchase is successful！</div>';
         
        }
       ?>
    <a href="index.php" >[ Return to products page ]</a>
		</div>
		<div class="col-md-3">
			
		</div>
	</div>

<?php include 'footer.php'; ?>
