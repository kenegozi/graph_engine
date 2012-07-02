Fabricator("GraphEngine::FbPlace") do
  name Faker::Name.first_name
  ext_fb_place_id { rand(11**14-7)+10 }
  street { Faker::Address.street_name }
  city { Faker::Address.city }
  country { Faker::Address.country }
  zip { Faker::Address.zip_code }
end
