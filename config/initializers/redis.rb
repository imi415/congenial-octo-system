module LiveAuth
  class RedisStore
    Redis = Redis.new(host: '127.0.0.1', port: 6379, db: 0)
  end
end
