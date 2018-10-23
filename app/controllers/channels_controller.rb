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
    @channel.valid_for = Time.now + channel_params[:valid_for].to_i.seconds
    @channel.user = User.find(session[:user_id])

    respond_to do |format|
      if @channel.save
        LiveAuth::RedisStore::Redis.set("hls_imi_#{@channel.name}_key", @channel.streamkey)
        if @channel.expires then
          LiveAuth::RedisStore::Redis.expire("hls_imi_#{@channel.name}_key", channel_params[:valid_for].to_i)
        end
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
    if params[:channel][:regen_key] then
      @channel.streamkey = SecureRandom.hex(32)
      @channel.save
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
    LiveAuth::RedisStore::Redis.expire("hls_imi_#{@channel.name}_key", -1)
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
      params.require(:channel).permit(:name, :expires, :valid_for)
    end
end
