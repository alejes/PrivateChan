<?php

include ROOT . 'libraries/htmlpurifier/library/HTMLPurifier.includes.php';

function escape($str){
	$config = HTMLPurifier_Config::createDefault();
	$config->set('Attr.AllowedClasses',array('header', 'math-tex')); // ��� Attr.ForbiddenClasses ������� ����� CSS ������
	$config->set('AutoFormat.RemoveEmpty',true); // ������� ������ ����, ���� ����������*
	$config->set('HTML.Doctype','HTML 4.01 Strict'); // �������� �������� ��� ��������� ��� <strike>
	$purifier = new HTMLPurifier($config);
	$clean_html = $purifier->purify($str);
	return mysql_real_escape_string($clean_html);
}
function redirect($url){
	header("Location: ".$url);
}
?>