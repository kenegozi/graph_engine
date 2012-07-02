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

Fabricator("GraphEngine::FacebookUser", from: "GraphEngine::User") do
  fb_uid { 617090967 }
  fb_oauth_token { "120600291315567|4d6856a4a2de22f83c0a32fe.1-617090967|xlUIcMOgO2O6gU6F8N3RKJ4FySM" }
end