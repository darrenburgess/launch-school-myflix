class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = Review.new(review_params)
    @review.video = @video
    @review.user = current_user

    if @review.save
      flash[:message] = "Your review was created"
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews
      flash[:error] = "All fields are required"
      render "videos/show"
    end
  end

  private

  def review_params
    params.require(:review).permit!
  end
end
