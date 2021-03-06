class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.where(:user => @user)
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
    @channel.streamkey = SecureRandom.hex(32)
    @channel.valid_for = DateTime.parse(channel_params[:valid_for])
    @channel.user = User.find(session[:user_id])
    @channel.expires = channel_params[:expires]
    respond_to do |format|
      if @channel.save
        ::RManager.add_or_update_channel(@channel)

        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    if params[:channel][:regen_key] == "1" then
      @channel.streamkey = SecureRandom.hex(32)
    end
    orig_name = @channel.name
    @channel.name = channel_params[:name]
    @channel.expires = channel_params[:expires]
    @channel.valid_for = DateTime.parse(channel_params[:valid_for])
    @channel.is_enabled = channel_params[:is_enabled]

    if @channel.save then
      ::RManager.add_or_update_channel(@channel, {:change_name => (@channel.name != orig_name), orig_name: orig_name})
    end

    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    LiveAuth::RedisStore::Redis.expire("#{ENV['LIVE_NAME']}_#{@channel.name}_key", -1)
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name, :expires, :valid_for, :is_enabled)
    end
end
