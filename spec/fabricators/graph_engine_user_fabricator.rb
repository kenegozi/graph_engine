Fabricator('GraphEngine::User') do
  ext_app_type { GraphEngine::ExtAppType::GOGOBOT }
  ext_user_id { sequence(:ext_user_id, 1000000000) }
  gogobot_user_id { sequence(:ext_user_id, 1000000000) }
  ext_display_name { Faker::Internet.user_name }
  email_enabled true
  email { Faker::Internet.email }
  username { Faker::Internet.user_name }
  fb_uid { SecureRandom.random_number(100000000) }
end