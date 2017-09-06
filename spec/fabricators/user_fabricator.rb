Fabricator(:user) do
  email { Faker::Internet.email }
  full_name { Faker::Simpsons.character }
  password "password" 
end
