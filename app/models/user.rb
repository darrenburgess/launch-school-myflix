class User < ActiveRecord::Base
  validates_presence_of :email, :full_name
  validates_uniqueness_of :email, case_sensitive: false

  has_secure_password
end
