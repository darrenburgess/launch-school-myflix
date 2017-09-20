class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = QueueItem.where(user_id: session[:user_id])
  end
end
