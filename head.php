<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/bootstrap.min.css">

<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<title><?php echo $title ?></title>
</head>

<body>
 <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container-fluid">

   <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
      </button>
       <a class="navbar-brand" href="index.php"><h3>Shopping Cart</h3></a>
       
   </div>
   <div class="collapse navbar-collapse"  id="navbar-collapse">
      <ul class="nav navbar-nav navbar-right">
       <li class="dropdown">
          <a  class="navbar-green" href="index.php" class="dropdown-toggle" data-toggle="dropdown">
           Data Sheet<!-- <span class="caret"></span> -->
          </a>
          <ul class="dropdown-menu">
               <li ><a href="show_employees.php">Employees</a></li>
          <li><a href="show_customers.php">Customers</a></li>
           <li ><a href="show_suppliers.php">Suppliers</a></li>
           <li><a href="show_products.php">Products</a></li> 
          <li><a href="show_purchases.php">Purchases</a></li>
          <li><a href="show_logs.php">Logs</a></li>
          </ul>
       </li>
       
          <li class="navbar-item-features"><a  class="navbar-blue" href="first.php">Sign out</a></li>   

      </ul>
   </div>
  </div>
</nav>

<header class="header-home">
  <div class="container-fluid">
  <div class="row">
  <div class="col-sm-4 col-sm-offset-8 col-xs-12 header-text">
      <BR> <BR> <BR> <BR>
  <h1>Everything you can get here</h1>
  </div>
  </div>
  </div>
</header>
<div class="container-fluid">