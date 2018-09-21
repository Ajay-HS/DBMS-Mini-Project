
<?php 
  $title="Home";
  include 'cus_head.php';
?>
<script language="javascript">
 	
	
	function num_check(e)
 	{ 	
		var code=e.keyCode;
		if(!(code>=47 && code<=58))
		{
			alert("Error :- Enter Only Numbers.");
			e.keyCode=0;
		}
	}
        </script>
        
  <ol class="breadcrumb">
    <li><a>Product</a></li>
    <li><a>List</a></li>
  </ol>
  
  <div class="row">
 <?php 
  require_once('conn.php');
   $cid = $_GET['cid'];
    $amt = $_GET['amt'];
   ?>
  <form name="f1" method="post" action="user_info2.php" enctype="multipart/form-data">
      	    <table width="84%" height="509" align="center">
              <tr align="center">
                <td height="71" colspan="4"><h2 class="subheader biggest" align="center">Your Information </h2></td>
              </tr>
              <tr>
               <tr>
                <td width="49%" height="46" align="right"><span class="style5"><font size="+2">Customer Id:&nbsp;&nbsp;&nbsp; </font></span></td>
                <td width="51%" colspan="2"><input name="cid" type="text" style="background-color:#CCCCCC" size="20" maxlength="10" value="<?php echo $cid;?>" readonly></td>
              </tr>
               <tr>
                <td width="49%" height="46" align="right"><span class="style5"><font size="+2">Amount:&nbsp;&nbsp;&nbsp; </font></span></td>
                <td width="51%" colspan="2"><input name="t1" type="text" style="background-color:#CCCCCC" size="20" maxlength="10" value="<?php echo $amt;?>" readonly></td>
              </tr>
             <tr>
                <td height="46" align="right"><span class="style5"><font size="+2">Card No:&nbsp;&nbsp;&nbsp;</font></span></td>
                <td colspan="2"><input name="t4" type="text" style="background-color:#CCCCCC" size="30" maxlength="10" onkeypress="num_check(event)"/></td>
              </tr>
              
              <tr> </tr>
              <tr align="center">&nbsp;&nbsp;&nbsp;
                <td height="58"  colspan="3"><label></label>
                  <input name="submit" type="submit" value="    I agree purchase   "/> 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="reset" name="Reset" value="    Reset    " /></td>
              </tr>
			  <tr>
			  	<td height="49" colspan="2" align="center"><a href="cart_list.php?cid=<?php echo $cid;?>"><font color="#00CC33" size="+1">Back</font></a></td>
			  </tr>
      	      
            </table>
		  </form>
  </div>  

<?php include 'footer.php'; ?>