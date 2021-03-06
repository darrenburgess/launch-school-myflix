require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email).case_insensitive}
  it {should validate_presence_of(:full_name)}
  it {should validate_presence_of(:password)}
end
