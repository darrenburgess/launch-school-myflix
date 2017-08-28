require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "some category")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    category = Category.create(name: "the category")
    south_park = Video.create(title: "South Park", description: "description", category: category)
    futurama = Video.create(title: "Futurama", description: "description", category: category)

    expect(category.videos).to include(south_park, futurama)
    expect(category.videos).to eq([futurama, south_park])
  end
end
