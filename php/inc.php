<?php
require __DIR__ . '/vendor/autoload.php';

$dotenv = new Dotenv\Dotenv(__DIR__ . '/../');
$dotenv->load();

$redis = new Redis();

$redis -> connect($_ENV['REDIS_HOST'], $_ENV['REDIS_PORT']);

$redis -> select($_ENV['REDIS_DB']);
