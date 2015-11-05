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
    //Разрешить iframes только с доверенных источников
    $config->set('HTML.SafeIframe', true);
    $config->set('URI.SafeIframeRegexp', '%^(https?:)?//(www\.youtube(?:-nocookie)?\.com/embed/|player\.vimeo\.com/video/)%'); //разрешить только YouTube и Vimeo
    $config->set('HTML.Doctype','HTML 5'); // преобразование некоторых тегов, например <strike>, в соответствии с HTML 5
    $purifier = new HTMLPurifier($config);
    $clean_html = $purifier->purify($str);
    //Принудительно разворачиваем все видео на полный экран
    $clean_html = str_replace('src="https://www.youtube.com', ' allowfullscreen src="https://www.youtube.com', $clean_html);
    return mysql_real_escape_string($clean_html);
}

function redirect($url){
    header("Location: ".$url);
}

?>