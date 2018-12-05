<?php
require_once('inc.php');

$app = $_POST['app'];
$name = $_POST['name'];
$key = $_POST['key'];

$rm = new RtmpManager($app, $name);

if ($rm->auth_stream($key)) {
}
else {
    header("HTTP/1.1 403 Forbidden");
}
