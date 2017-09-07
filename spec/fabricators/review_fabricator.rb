Fabricator(:review) do
  content { Faker::Lorem.paragraph }
  rating Random.new.rand(1..5)
end
