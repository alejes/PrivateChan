<?php header("Cache-Control: no-cache, must-revalidate"); //HTTP 1.1 ?>
<?php header("Pragma: no-cache"); //HTTP 1.0 ?>
<?php header("Expires: Sat, 26 Jul 1997 05:00:00 GMT"); // Date in the past ?>
<!doctype html>
<html lang="ru">

<head>
 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content=".">
<meta name="keywords" content="">
<meta name="author" content="">

<title>AUChan</title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="/js/fancybox.js"></script>
<script type="text/javascript" src="/js/ui.js"></script>
<script src="/js/ckeditor/ckeditor.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/board.css" rel="stylesheet">
<link rel="stylesheet" href="/css/fancybox.css" type="text/css" media="screen" />

</head>

<body>
<div class="container">
<?php 
	Template::display("boards_header", array('boards_data' => $boards_data));
?>