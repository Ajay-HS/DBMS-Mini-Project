<?php
session_unset();
session_start();
ob_start();

?>
    <?php 
  $title="Home";
  include 'cus_head.php';
?>

<script type='text/javascript'>
function validateForm() {
    var x = document.forms["form1"]["lid"].value;
	var y = document.forms["form1"]["pass"].value;
    if (x == "" || y == "") {
        alert("Name and Password are required");
        return false;
    }
}
  
</script>
  
  <div class="row">
<center>
    <form name="form1" method="post" action="login_act.php" onsubmit="return validateForm()">
      <table width="913" border="0">
        <tr>
          <td width="564"><img align="center" height="354" width="466" src="img/img03.jpg" /></td>
          <td width="276">
           <table border="0">
                          <tr style="color: white">
                            <td bgcolor="#CCCACA" height="38" colspan="2"><div align="center"><h2>LOGIN TYPE</h2></div></td>
                          </tr>
                           <tr style="color: white">
                           <td bgcolor="#CCCACA" height="38" colspan="2"><div align="center"><a href="customerreg.php"><h4>New Customer</h4></a></div></td>
                          </tr>
                          <tr style="color: black">
                            <td height="50" colspan="2"><p align="center">
                              <label>
                                <input type="radio" name="user" value="Admin" id="Admin">
                                Admin</label>
                              <br>
                              
                              <label>
                                <input type="radio" name="user" value="user" id="Student">
                                Customer</label>
                            </p></td>
                          </tr>
                          <tr>
                              <td width="122" style="color: black"><div align="right">Username: &nbsp;&nbsp;</div></td>
                              <td width="158"><input type="text" name="lid" id="lid"><br></td>
                          </tr>
                          <tr>
                            <td style="color: black"><div align="right">Password:&nbsp;&nbsp;</div></td>
                            <td><input type="password" name="pass" id="pass"><br></td>
                          </tr>
                          <tr>
                            <td><div align="right"></div></td>
                            <td><input type="submit" name="submit" id="submit" value="Submit">                              <input type="reset" name="cancel" id="cancel" value="Reset"></td>
                          </tr>
              </table>
          
          
          &nbsp;          </td>
        </tr>
      </table>
        </form>
      </center>
    
  </div>  

<?php include 'footer.php'; ?>
<?php
session_write_close();
ob_end_flush();
?>
