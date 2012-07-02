Fabricator("GraphEngine::FbCheckin") do
  application_name { Faker::Name.first_name }
  application_id { SecureRandom.random_number(100000) }
  ext_fb_checkin_id { SecureRandom.random_number(100000) }
  ext_fb_place_id { SecureRandom.random_number(100000) }
  fb_uid { SecureRandom.random_number(100000) }
end
