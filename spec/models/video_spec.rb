require 'spec_helper'

describe Video do
  it "saves itself" do
    category = Category.create(name: "Some category")
    video = Video.new(title: "Some title", description: "Some description", category: category)
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to a category" do
    category = Category.create(name: "Some category")
    video = Video.create(title: "Some title", description: "the description", category: category)
    expect(video.category).to eq(category)
  end

  it "is valid with correct attributes" do
    category = Category.create(name: "Some category")
    video = Video.create(title: "Some title", description: "the description", category: category)
    expect(video).to be_valid
  end

  it "is not valid without a title" do
    category = Category.create(name: "Some category")
    video = Video.new(title: nil, description: "the description", category: category)
    expect(video).to_not be_valid
  end

  it "is not valid without a description" do
    category = Category.create(name: "Some category")
    video = Video.new(title: "sometitle", description: nil, category: category)
    expect(video).to_not be_valid
  end

  it "is not valid without a category" do
    video = Video.new(title: "sometitle", description: "the description", category: nil)
    expect(video).to_not be_valid
  end
end
