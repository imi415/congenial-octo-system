<?php
require_once('inc.php');

$app = $_POST['app'];
$name = $_POST['name'];

$rm = new RtmpManager($app, $name);

$rm.set_stream_status('off');
