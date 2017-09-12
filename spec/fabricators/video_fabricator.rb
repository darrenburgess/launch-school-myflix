Fabricator(:video) do
  title { Faker::Lorem.sentence }
  description { Faker::Lorem.sentence }
  category
end
