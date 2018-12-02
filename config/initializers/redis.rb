module LiveAuth
  class RedisStore
    Redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: ENV['REDIS_DB'])
    Redis.flushdb
    @channels = Channel.all
    @channels.each do |ch| 
      Redis.set("#{ENV['LIVE_NAME']}_#{ch.name}_key", ch.streamkey)
      if ch.expires then
        Redis.expireat("#{ENV['LIVE_NAME']}_#{ch.name}_key", ch.valid_for.to_i)
      end
    end
  end
end
