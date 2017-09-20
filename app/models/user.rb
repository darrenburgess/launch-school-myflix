class User < ActiveRecord::Base
  has_many :queue_items

  validates_presence_of :email, :full_name
  validates_uniqueness_of :email, case_sensitive: false

  has_secure_password
end
