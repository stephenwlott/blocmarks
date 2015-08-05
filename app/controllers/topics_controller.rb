class TopicsController < ApplicationController
  def index
    @user = current_user
    @topics = current_user.topics
  end

  def show
    @topic = current_user.topics.find(params[:id])
    @user = current_user
  end

  def new
    if current_user
      @topic = Topic.new
      @id = @topic.id
      @user = current_user
    end
  end

  def edit
    @topic = current_user.topics.find(params[:id])
    @user = current_user
  end

  def update
    @topic = current_user.topics.find(params[:id])
    @user = current_user
    if @topic.update_attributes(params.require(:topic).permit(:title))
      @topic.reload
      flash[:notice] = "Topic was updated."
      redirect_to user_topics_path(:id, :user_id)
    else
      flash[:error] = "Error updating topic. Please try again."
      render :update
    end
  end

  def create
    @topic = current_user.topics.new(params.require(:topic).permit(:title, :user_id))
    @id = @topic.id
    @user = current_user
    if @topic.save
      redirect_to user_topics_path(:id, :user_id), notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def destroy
    @topic = current_user.topics.find(params[:id])
    if @topic.destroy
      flash[:notice] = "Topic was deleted."
    else
      flash[:error] = "Topic couldn't be deleted. Try again."
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
