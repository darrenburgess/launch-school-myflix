require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Some title", description: "Some description")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to a category" do
    category = Category.create(name: "Some category")
    video = Video.create(title: "Some title", description: "the description", category: category)
    expect(video.category).to eq(category)
  end
end
