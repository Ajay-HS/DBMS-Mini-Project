<?php 
  $title="Home";
  include 'cus_head.php';
?>

  
  
  <div class="row">
<center>
    <br>
     <h1>CUSTOMER REGISTRATION FORM</h1>
      <br>
    
      <form name="form1" method="post" action="cus_reg_act.php" onSubmit="return check();">
     
       <table width="525" border="0" align="left">
         <tr>
           <td width="122"><div align="left" class="style7">Name </div></td>
           <td width="288"><input type="text" name="cname"></td>
         </tr>
         <tr>
           <td class="style7">Password</td>
           <td><input type="password" name="pass"></td>
         </tr>
         
         <tr>
           <td class="style7">City</td>
           <td><input name="city" type="text" id="city"></td>
         </tr>
         
         <tr>
           <td>&nbsp;</td>
           <td><input type="submit" name="Submit" value="Signup"></td>
         </tr>
       </table>
     </form>
      </center>
    
  </div>  

<?php include 'footer.php'; ?>