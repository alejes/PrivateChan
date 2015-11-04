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
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/board.css" rel="stylesheet">

</head>

<body>
<div class="container">
<?php 
	Template::display("boards_header", array('boards_data' => $boards_data));
?>