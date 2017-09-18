require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order("created_at DESC") }

  describe "search for video" do
    it "returns an empty array if there is no match" do
      category = Category.create(name: "Comedy")
      Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title("some title")).to eq([])
    end

    it "returns an array of one video if there is a exact match" do
      category = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title("Family Guy")).to eq([family_guy])
    end

    it "returns an array of one video if there is a partial match" do
      category = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title("Family")).to eq([family_guy])
    end

    it "returns an array of one video if partail match, ignoring case" do
      category = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title("family")).to eq([family_guy])
    end

    it "returns an array of matching videos ordered by created_at" do
      category = Category.create(name: "Action")
      matrix1 = Video.create(title: "Matrix", description: "awesome", category: category, created_at: 1.day.ago)
      matrix2 = Video.create(title: "Matrix Reloaded", description: "awesome", category: category)
      expect(Video.search_by_title("matrix")).to eq([matrix2, matrix1])
    end

    it "returns empty array if search term is an empty string" do
      category = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title("")).to eq([])
    end

    it "returns empty array if search term is nil" do
      category = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "the description", category: category)
      expect(Video.search_by_title(nil)).to eq([])
    end
  end
end
