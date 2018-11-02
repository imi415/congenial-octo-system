class LivesController < ApplicationController
  before_action :set_channel, only: [:show]

  def index
    @channels = Channel.where(:is_enabled => true)
    @channels.each { | ch |
      ch.status = (LiveAuth::RedisStore::Redis.get("#{ENV['LIVE_NAME']}_#{ch.name}_status") == 'on') ? true : false;
    }
  end


  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find_by(:name => params[:name])
    end
end
