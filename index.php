
<?php 
  $title="Home";
  include 'head.php';
?>
<?php 
  require_once('conn.php');
  $sql = "call show_products();";
  $query = mysql_query($sql);
  if($query&&mysql_num_rows($query)){
    while($row = mysql_fetch_assoc($query)){
      $data[] = $row;
    }
  }
?>
  <ol class="breadcrumb">
    <li><a>Product</a></li>
    <li><a>List</a></li>
  </ol>
  
  <div class="row">

    <?php 
      if(!isset($data)) echo "<h3>No product information，Please add first</h3>";
      else{
        foreach ($data as $prod) {
          $prod['imgname'] = $prod['imgname']? $prod['imgname'] : 'no-image.png'; 
    ?>

    <div class="col-sm-6 col-md-4">
      <div class="thumbnail">
        <img src="img/<?php echo $prod['imgname'] ?>" >
        <div class="caption">
           <p>Product Name： <small><?php echo $prod['pname'];?></small></p>
            <p>Product Price：<small><?php echo $prod['original_price'];?></small></p>
            <p>Total Inventory：<small><?php echo $prod['qoh'];?></small></p>
            <p>Discount Rate：<small><?php echo $prod['discnt_rate'];?></small></p>
            <p>
After the price discount：<small><?php echo $prod['original_price']-($prod['discnt_rate']);?></small></p>
            <p>
              
               <a href="purchase.php?pid=<?php echo $prod['pid'];?>" class="btn btn-info" role="button">Sales</a>       
                 </p>
        </div>
      </div>
    </div>
    <?php }} ?>

  </div>  
<script type="text/javascript">
function show_confirm(){
  var r=confirm("OK to delete the product？（Operation can not be resumed）");
  if (r==true)
    return true;
  else
    return false;
}
</script>
<?php include 'footer.php'; ?>