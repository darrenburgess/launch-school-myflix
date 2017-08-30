require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

  describe "#recent_vidoes" do
    it "sorts the videos in descending order by created_at" do
      comedy = Category.new(name: "Comedy")
      3.times do |index|
        Video.create(title: "Video #{index}", description: "description",
                     category: comedy,
                     created_at: index.days.from_now)
      end

      video1 = comedy.videos.first
      video2 = comedy.videos.second
      video3 = comedy.videos.third

      expect(comedy.recent_videos).to eq([video1, video2, video3])
    end

    it "returns all videos if there are less than 6" do
      comedy = Category.new(name: "Comedy")
      3.times do |index|
        Video.create(title: "Video #{index}", description: "description",
                     category: comedy,
                     created_at: index.days.from_now)
      end

      expect(comedy.recent_videos.count).to eq 3
    end

    it "returns 6 videos if there are more than 6" do
      comedy = Category.new(name: "Comedy")
      7.times do |index|
        Video.create(title: "Video #{index}", description: "description",
                     category: comedy,
                     created_at: index.days.from_now)
      end

      expect(comedy.recent_videos.count).to eq 6
    end

    it "returns the most recent 6 videos" do
      comedy = Category.new(name: "Comedy")
      6.times{|index| Video.create(title: "Video #{index}", description: "d", category: comedy)}
      older_video = Video.create(title: "title", description: "d", category: comedy, created_at:1.day.ago)
      expect(comedy.recent_videos).to_not include(older_video)
    end

    it "returns an empty array if category has no videos" do
      comedy = Category.new(name: "Comedy")
      expect(comedy.recent_videos).to eq []
    end
  end
end
