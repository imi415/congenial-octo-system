<?php
require_once('inc.php');

$app = $_POST['app'];
$name = $_POST['name'];

$status_key = $app . '_' . $name . '_status';
$redis ->set($status_key, 'off');

