class VideosController < ApplicationController
  before_action :set_video, only: [:show]
  before_action :set_categories, only: [:index]

  def index
  end

  def show
  end

  def search
    @videos = Video.search_by_title(params[:search_term]) 
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def video_params
    params.require(:video).permit!
  end
end
