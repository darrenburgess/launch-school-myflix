class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  # TODO: creates a race condition that should be resolved with database constraints
  #       and trapping for ActiveRecord::RecordNotUnique exception
  validates_uniqueness_of :user_id, scope: :video_id

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
  end
end

