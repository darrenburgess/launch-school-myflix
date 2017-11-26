require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer   
  }
  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: "South Park")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq "South Park"
    end
  end

  describe "#rating" do
    it "returns the logged in users rating of the associated video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq 5
    end
  end

  describe "#rating=" do
    it "changes rating of review if there is a review" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = 4
      expect(Review.first.rating).to eq 4
    end

    it "clears the rating of the review if there is a review" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 5)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = ""
      expect(Review.first.rating).to be_nil
    end

    it "creates a new review if it is not present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = 5
      expect(Review.first.rating).to eq 5
    end
  end

  describe "#category_name" do
    it "returns the category name for associated video" do
      user = Fabricate(:user)
      comedy = Fabricate(:category, name: "comedy")
      video = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.category_name).to eq "comedy"
    end
  end

  describe "#category" do
    it "returns the category object for the associated video" do
      user = Fabricate(:user)
      comedy = Fabricate(:category, name: "comedy")
      video = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.category).to eq comedy
    end  
  end
end
