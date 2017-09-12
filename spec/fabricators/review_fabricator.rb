Fabricator(:review) do
  content { Faker::Lorem.sentence }
  rating Random.new.rand(1..5)
end
