class LivesController < ApplicationController
  before_action :set_channel, only: [:show]

  def index
    @channels = Channel.all
  end


  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find_by(:name => params[:name])
    end
end
