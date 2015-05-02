<?php
/**
 * utf-8のエスケープ文字を読める文字に変換する \n
 *  Usage : php toReadableUtf8.php -s [unicode_escape_sequence]
 */
$options = getopt('s:');
$string  = isset($options['s']) ? $options['s'] : '';
if ($string !== '') {
    echo preg_replace_callback('/\\\\u([0-9a-f]{4})/i', 'replace_unicode_escape_sequence', $string).PHP_EOL;
}

function replace_unicode_escape_sequence($match)
{
    return mb_convert_encoding(pack('H*', $match[1]), 'UTF-8', 'UCS-2BE');
}
