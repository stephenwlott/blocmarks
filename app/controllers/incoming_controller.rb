class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    Rails.logger.debug "--- IncomingController#create ---"
#    Rails.logger.debug "--- INCOMING PARAMS: #{params.inspect} ---"
    
    # assume that email body consists of url only
    incoming_url = params[:"body-plain"]
    Rails.logger.debug "--- incoming_url: #{incoming_url}"
    
    incoming_email = params[:sender]
    Rails.logger.debug "--- incoming_email: #{incoming_email}"
    
    incoming_topic = params[:Subject]
    Rails.logger.debug "--- incoming_topic: #{incoming_topic}"
    
    #Rails.logger.debug "--- User.count = #{User.count}"
    #Rails.logger.debug "--- User.first.email = #{User.first.email}"
    
    #test_user = User.where(email: incoming_email.to_str).first
    #if test_user
    #  Rails.logger.debug "--- 1 test_user found for email: #{incoming_email}"
    #else
    #  Rails.logger.debug "--- 1 test user not found for email #{incoming_email}"
    #end
      
    #test_user = User.find_by(email: incoming_email.to_str)
    #if test_user
    #  Rails.logger.debug "--- 2 test_user found for email: #{incoming_email}"
    #else
    #  Rails.logger.debug "--- 2 test_user not found for email: #{incoming_email}"
    #end
    
    bookmark_user = User.find_or_create_by!(:email => incoming_email) do |u|
      Rails.logger.debug "--- 2 created new user for #{incoming_email} ---"
    end

    #test_topic = Topic.find_by(title: incoming_topic.to_str)
    ##if test_topic
    #  Rails.logger.debug "--- 3 test_topic found for title: #{incoming_topic}"
    #else
    #  Rails.logger.debug "--- 3 test_topic not found for title: #{incoming_topic}"
    #end
    
    bookmark_topic = Topic.find_or_create_by!(:title => incoming_topic, :user_id => bookmark_user.id) do |t|
      Rails.logger.debug "--- 3 created new topic for #{t.title}"
    end

    # create a new bookmark
    @bookmark = Bookmark.find_or_create_by!(:url => incoming_url, :topic_id => bookmark_topic.id) do |b|
      Rails.logger.debug "--- 4 created new bookmark for url: #{incoming_url} and topic_id: #{bookmark_topic.id}"
    end
    
    # Assuming all went well. 
    head 200
  end
end