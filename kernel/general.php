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
    $config->set('Attr.AllowedClasses',array('header', 'math-tex', 'border')); // или Attr.ForbiddenClasses, если имеются ввиду запрещённые CSS классы
    $config->set('AutoFormat.RemoveEmpty',true); // удаляет пустые теги, но есть исключения описанные в документации http://htmlpurifier.org/live/configdoc/plain.html#AutoFormat.RemoveEmpty
    $config->set('HTML.Doctype','HTML 4.01 Strict'); // преобразование некоторых тегов, например <strike>, в соответствии с HTML 4.01 Strict.
    $purifier = new HTMLPurifier($config);
    $clean_html = $purifier->purify($str);
    return mysql_real_escape_string($clean_html);
}

function redirect($url){
    header("Location: ".$url);
}

?>