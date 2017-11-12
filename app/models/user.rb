class User < ActiveRecord::Base
  has_many :queue_items, -> {order("position")}

  validates_presence_of :email, :full_name
  validates_uniqueness_of :email, case_sensitive: false

  has_secure_password

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end
end
