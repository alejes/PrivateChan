<?php

/**
    * Часто используемые функции
*/

include ROOT . 'libraries/htmlpurifier/library/HTMLPurifier.includes.php';

function full_escape($str){
    return mysql_real_escape_string(htmlspecialchars($str, ENT_QUOTES));
}

function escape($str){
    $config = HTMLPurifier_Config::createDefault();
    $config->set('Attr.AllowedClasses',array('header', 'math-tex', 'border')); // или Attr.ForbiddenClasses имеются ввиду CSS классы
    $config->set('AutoFormat.RemoveEmpty',true); // удаляет пустые теги, есть исключения*
    $config->set('HTML.Doctype','HTML 4.01 Strict'); // обратите внимание как заменился тег <strike>
    $purifier = new HTMLPurifier($config);
    $clean_html = $purifier->purify($str);
    return mysql_real_escape_string($clean_html);
}

function redirect($url){
    header("Location: ".$url);
}

?>