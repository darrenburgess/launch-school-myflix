class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = QueueItem.where(user_id: session[:user_id]).order("position ASC")
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = QueueItem.new(video: video, user: current_user)
    last_item = QueueItem.last
    queue_item.position = last_item ? last_item.position + 1 : 1 

    if queue_item.save
      redirect_to queue_items_path
    else
      flash[:notice] = "Video already in your queue"
      render "videos/show"
    end
  end

  def destroy
    queue_item = QueueItem.find(params[:id])

    if queue_item.user_id == current_user.id
      queue_item.destroy
      redirect_to queue_items_path
    else
      redirect_to queue_items_path
    end
  end
end
