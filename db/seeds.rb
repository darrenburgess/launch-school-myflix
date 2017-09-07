unless User.find_by(email: "darrentburgess@gmail.com")
  User.create(email: "darrentburgess@gmail.com", password: "password", full_name: "Darren Burgess")
end

unless User.find_by(email: "steve@jones.com")
  steve = User.create(email: "steve@jones.com", password: "password", full_name: "Steve Jones")
end

unless Category.find_by(name: "Comedy")
  comedy = Category.create(name: "Comedy")
end

unless Category.find_by(name: "Drama")
  drama = Category.create(name: "Drama")
end

unless Video.find_by(title: "Southpark")
  Video.create(
          title: "Southpark", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/south_park.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 7.days.ago,
          category: comedy
  )
end

unless Video.find_by(title: "Family Guy")
  Video.create(
          title: "Family Guy", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/family_guy.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 6.days.ago,
          category: comedy
  )
end

family_guy = Video.find_by(title: "Family Guy")

3.times do
  Review.create(
           content: Faker::Lorem.paragraph(2),
           rating: Random.new.rand(1..5),
           video: family_guy,
           user: steve
        )
end

unless Video.find_by(title: "Futurama")
  Video.create(
          title: "Futurama", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/futurama.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 5.days.ago,
          category: comedy
  )  
end

unless Video.find_by(title: "Freaks and Geeks")
  Video.create(
          title: "Freaks and Geeks", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/freaks_and_geeks.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 4.days.ago,
          category: comedy
  )  
end

unless Video.find_by(title: "Marco Polo")
  Video.create(
          title: "Marco Polo", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/marco_polo.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 3.days.ago,
          category: comedy
  )  
end

unless Video.find_by(title: "The Ranch")
  Video.create(
          title: "The Ranch", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/the_ranch.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 2.days.ago,
          category: comedy
  )  
end

unless Video.find_by(title: "Vampire Diaries")
  Video.create(
          title: "Vampire Diaries", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/vampire_diaries.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          created_at: 1.days.ago,
          category: comedy
  )  
end

unless Video.find_by(title: "Monk")
  Video.create(
          title: "Monk", 
          description: "Sit minus cum accusantium voluptas cumque incidunt sapiente. Culpa ullam ad numquam in impedit, alias commodi quia totam optio maxime libero cupiditate. Harum similique non doloribus veniam delectus dignissimos ipsam.", 
          small_cover_url: "/tmp/monk.jpg",
          large_cover_url: "/tmp/monk_large.jpg",
          category: drama
  )
end
