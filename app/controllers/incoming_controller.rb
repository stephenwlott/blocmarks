class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "--- IncomingController#create ---"
    puts "--- INCOMING PARAMS: #{params.inspect} ---"
    
    # assume that email body consists of url only
    bookmark_url = params[:body-plain]
    puts "--- bookmark_url: #{bookmark_url} ---"
    
    user_email = params[:sender]
    puts "--- user_email: #{user_email}"
    user = User.find_or_create_by!(:email => user_email) do |u|
      puts "--- created new user for #{user_email}, id = u.id ---"
    end
    
    bookmark_topic = params[:Subject]
    puts "--- bookmark_topic: #{bookmark_topic} ---"
    topic = Topic.find_or_create_by!(:title => bookmark_topic, :user_id => user.id) do |t|
      puts "--- created new topic for #{t.title} ---"
    end

    # create a new bookmark
    @bookmark = Bookmark.create!(:url => bookmark_url, :topic_id => topic.id)

    # Assuming all went well. 
    head 200
  end
end