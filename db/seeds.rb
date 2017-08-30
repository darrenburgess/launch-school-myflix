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
          created_at: 7.days.ago,
          category: comedy
  )
end

unless Video.where(title: "Family Guy").first
  Video.create(
          title: "Family Guy", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/family_guy.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 6.days.ago,
          category: comedy
  )
end

unless Video.where(title: "Futurama").first
  Video.create(
          title: "Futurama", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/futurama.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 5.days.ago,
          category: comedy
  )  
end

unless Video.where(title: "Freaks and Geeks").first
  Video.create(
          title: "Freaks and Geeks", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/freaks_and_geeks.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 4.days.ago,
          category: comedy
  )  
end

unless Video.where(title: "Marco Polo").first
  Video.create(
          title: "Marco Polo", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/marco_polo.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 3.days.ago,
          category: comedy
  )  
end

unless Video.where(title: "The Ranch").first
  Video.create(
          title: "The Ranch", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/the_ranch.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 2.days.ago,
          category: comedy
  )  
end

unless Video.where(title: "Vampire Diaries").first
  Video.create(
          title: "Vampire Diaries", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/vampire_diaries.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 1.days.ago,
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
