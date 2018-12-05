<?php
require __DIR__ . '/vendor/autoload.php';

$dotenv = new Dotenv\Dotenv(__DIR__ . '/../');
$dotenv->load();

class RtmpManager {
    private $redis;
    private $app;
    private $name;

    function __construct($param_app, $param_name) {
        $this->app = $param_app;
        $this->name = $param_name;

        $this->redis = new Redis();
        $this->redis->connect($_ENV['REDIS_HOST'], $_ENV['REDIS_PORT']);
        $this->redis->select($_ENV['REDIS_DB']);
    }

    function auth_stream($param_key) {

        $redis_enabled = $this->redis->get($_ENV['LIVE_NAME'] . '_' . $this->name . '_enabled');

        if ($redis_enabled) {
            $redis_key = $this->redis->get($_ENV['LIVE_NAME'] . '_' . $this->name . '_key');
            if ($redis_key === $param_key) {
                return true;
            }
        }
        return false;
    }

    function auth_update() {
        $redis_enabled = $this->redis->get($_ENV['LIVE_NAME'] . '_' . $this->name . '_enabled');

        if ($redis_enabled) {
            return true;
        }
        return false;
    } 

    function set_stream_status($param_status) {
        $status_key = $_ENV['LIVE_NAME'] . '_' . $this->name . '_status';
        if ($param_status != 'on') {
            $this->redis ->del($status_key);
        } else {
            $this->redis ->set($status_key, $param_status);
        }
    }
}