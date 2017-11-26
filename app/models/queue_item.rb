class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  # TODO: creates a race condition that should be resolved with database constraints
  #       and trapping for ActiveRecord::RecordNotUnique exception
  validates_uniqueness_of :user_id, scope: :video_id
  validates_numericality_of :position, only_integer: true

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    review = Review.where(user_id: user.id, video_id: video.id).first

    if review
      review.rating = new_rating
    else
      review = Review.new(user: user, video: video, rating: new_rating)
    end

    review.save(validate: false)
  end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end

