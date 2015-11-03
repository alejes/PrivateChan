<?php
require "config.php";
require "libraries/router.php";
require "libraries/template.php";

Router::route();


require(ROUTE_CONTROLLER_PATH);

$class = ROUTE_MODULE;
$controller = new $class();


if ( ! empty(Router::$action)) {

    $action_method = 'action_'. Router::$action;
    
    if (method_exists($controller, $action_method)) {
        $controller->$action_method();
    }
    else  throw new Exception('00404');
}
else {
	if (method_exists($controller, 'action_default')) {
        $controller->action_default();
    }else  	throw new Exception('00404');
}

//echo 'Supper pupper bashes';



?>