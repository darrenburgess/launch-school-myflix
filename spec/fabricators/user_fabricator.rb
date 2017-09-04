Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Simpsons.character }
  password { Faker::Lorem.characters(10) }
end
