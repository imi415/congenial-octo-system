<?php
require_once('inc.php');

$app = $_POST['app'];
$name = $_POST['name'];
$key = $_POST['key'];

$redis_key = $_ENV['LIVE_NAME'] . '_' . $name . '_key';

$key_from_redis = $redis -> get($redis_key);

//error_log($key . ' ' . $key_from_redis, 0);

if ($key_from_redis === $key) {
    $status_key = $_ENV['LIVE_NAME'] . '_' . $name . '_status';
    $redis ->set($status_key, 'on');
}
else {
    header("HTTP/1.1 403 Forbidden");
}

