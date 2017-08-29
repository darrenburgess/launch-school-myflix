# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

unless Category.where(name: "Comedy").first
  comedy = Category.create(name: "Comedy")
end

unless Category.where(name: "Drama").first
  drama = Category.create(name: "Drama")
end

unless Video.where(title: "Southpark").first
  Video.create(
          title: "Southpark", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/south_park.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          category: comedy
  )
end

unless Video.where(title: "Family Guy").first
  Video.create(
          title: "Family Guy", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/family_guy.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          category: comedy
  )
end

unless Video.where(title: "Futurama").first
  Video.create(
          title: "Futurama", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/futurama.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          category: comedy
  )  
end

unless Video.where(title: "Monk").first
  Video.create(
          title: "Monk", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/monk.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          category: drama
  )
end
