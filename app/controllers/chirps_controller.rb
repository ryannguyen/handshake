require 'uri'
require 'net/http'

class ChirpsController < ApplicationController
  def index
    # should do sort DESC
    @chirps = Chirp.all.order(:created_at).reverse
    @chirp = Chirp.new
  end

  def create
    @chirp = Chirp.new(chirp_params)
    @chirps = Chirp.all

    if @chirp.save
      post_push_notification()
      redirect_to '/'
    else
      @chirps = Chirp.all
      render :index
    end

    # ajax
    # respond_to do |format|
    #   if @chirp.save
    #     format.js
    #   else
    #     format.html {	render :index }
    #   end
    # end
  end

  def upvote
    @chirp = Chirp.find(params[:id])
    @chirp.upvote
    @chirp.save

    redirect_to '/'
  end

  def downvote
    @chirp = Chirp.find(params[:id])
    @chirp.downvote
    @chirp.save

    redirect_to '/'
  end

  private
  def chirp_params
    params.require(:chirp).permit(:text)
  end

  def post_push_notification
    Thread.new do
      url = "https://bellbird.joinhandshake-internal.com/push"
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
    
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    
      request.body = { chirp_id: "1234"}.to_json # SOME JSON DATA e.g {msg: 'Why'}.to_json
    
      response = http.request(request)

      # uri = URI('https://jsonplaceholder.typicode.com/posts')
      # res = Net::HTTP.post_form(uri, 'chirp_id' => '1234')
      # posts res.body  if res.is_a?(Net::HTTPSuccess)

      # if response fails, try again n number of times
    end
  end
end
    