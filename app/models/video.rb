class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order('created_at DESC') }
  has_many :queue_items, -> { order('position') }

  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true

  def self.search_by_title(title)
    return [] if title.blank?
    where('lower(title) LIKE ?', "%#{title.downcase}%").order("created_at DESC")
  end
end
