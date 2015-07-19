class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    Rails.logger.debug "--- IncomingController#create ---"
#    Rails.logger.debug "--- INCOMING PARAMS: #{params.inspect} ---"
    
    # assume that email body consists of url only
    bookmark_url = params[:"body-plain"]
    Rails.logger.debug "--- bookmark_url: #{bookmark_url}"
    bookmark_email = params[:sender]
    Rails.logger.debug "--- bookmark_email: #{bookmark_email}"
    bookmark_topic = params[:Subject]
    Rails.logger.debug "--- bookmark_topic: #{bookmark_topic}"
    
    Rails.logger.debug "--- User.count = #{User.count}"
    Rails.logger.debug "--- User.first.email = #{User.first.email}"
    
    bookmark_user = User.where(email: bookmark_email.to_str).first
    if bookmark_user
      Rails.logger.debug "--- 1 bookmark_user found, id = #{bookmark_user.id}"
    else
      Rails.logger.debug "--- 1 bookmark user not found for email #{bookmark_email}"
    end
      
    bookmark_user = nil
    bookmark_user = User.find_by(email: bookmark_email.to_str)
    if bookmark_user
      Rails.logger.debug "--- 2 bookmark_user found, id = #{bookmark_user.id}"
    else
      Rails.logger.debug "--- 2 bookmark user not found for email #{bookmark_email}"
    end
    
#    user = User.find_or_create_by!(:email => user_email) do |u|
#      Rails.logger.debug "--- created new user for #{user_email} ---"
#    end
    
#    topic = Topic.find_or_create_by!(:title => bookmark_topic, :user_id => user.id) do |t|
#      Rails.logger.debug "--- created new topic for #{t.title} ---"
#    end

    # create a new bookmark
#    @bookmark = Bookmark.create!(:url => bookmark_url, :topic_id => topic.id)

    # Assuming all went well. 
    head 200
  end
end