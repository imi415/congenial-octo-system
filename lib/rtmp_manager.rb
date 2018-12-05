class RtmpManager
    def initialize
        redis_init
        redis_flushdb
        load_channels
    end

    def add_or_update_channel(channel, opts = nil)

        if !opts.nil? && opts[:change_name] then
            redis_del("#{opts[:orig_name]}_key")
            redis_del("#{opts[:orig_name]}_original")
            redis_del("#{opts[:orig_name]}_enabled")
            redis_del("#{opts[:orig_name]}_status")
        end

        redis_set("#{channel.name}_key", channel.streamkey)

        if channel.allow_original then
            redis_set("#{channel.name}_original", "true") # Allow push original stream to hls.
        else
            redis_del("#{channel.name}_original")
        end
        
        if channel.is_enabled then
            redis_set("#{channel.name}_enabled", "true")

            if channel.expires then
                redis_expireat("#{channel.name}_enabled", channel.valid_for.to_i)
            end
        else
            redis_del("#{channel.name}_enabled") # Delete this key if this channel is no longer available.
        end
    end

    def channel_is_streaming?(channel)
        return (redis_get("#{channel.name}_status") == "on" ? true : false)
    end

    def delete_channel(channel)
        redis_del("#{channel.name}_key")
        redis_del("#{channel.name}_original")
        redis_del("#{channel.name}_enabled")
        redis_del("#{channel.name}_status")

    end

    def disable_channel(channel)
        redis_del("#{channel.name}_enabled")
    end

    def enable_channel(channel)
        redis_set("#{channel.name}_enabled", "true")

        if channel.expires then
            redis_expireat("#{channel.name}_enabled", channel.valid_for.to_i)
        end
    end

    def load_channels
        channels = Channel.all

        channels.each do | channel |
            add_or_update_channel(channel)
        end
    end

    private

    def redis_init
        @redis = Redis.new(
            host: ENV['REDIS_HOST'],
            port: ENV['REDIS_PORT'],
            db: ENV['REDIS_DB']
        )
        @redis_initialized = true
    end

    def redis_set(key, value)
        if @redis_initialized then
            @redis.set("#{ENV['LIVE_NAME']}_#{key}", value)
        end
    end

    def redis_get(key)
        if @redis_initialized then
            return @redis.get("#{ENV['LIVE_NAME']}_#{key}")
        end
        return nil
    end

    def redis_del(key)
        if @redis_initialized then
            @redis.del("#{ENV['LIVE_NAME']}_#{key}")
        end
    end

    def redis_expireat(key, timestamp)
        if @redis_initialized then
            @redis.expireat("#{ENV['LIVE_NAME']}_#{key}", timestamp)
        end
    end

    def redis_flushdb
        if @redis_initialized then
            @redis.flushdb
        end
    end
end