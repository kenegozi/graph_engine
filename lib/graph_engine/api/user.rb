module GraphEngine::Api
  class User
    # Public: Create or update a user with the user options.
    #
    # options - 
    #   gogobot_user_id *
    #   ext_app_type *
    #   ext_user_id *
    #   email *
    #   username *
    #   picture_url
    #   fb_oauth_token
    #   fb_uid
    #   tw_uid
    #   tw_oauth_token
    #   tw_oauth_secret
    #   fs_uid
    #   fs_access_token
    #   fs_access_secret
    #   fs_oauth_token
    #   facebook_friend_ids
    #   facebook_friend_of_friend_ids
    #   twitter_friend_ids
    #   foursquare_friend_ids
    # 
    # Returns a graph user
    def self.create(options = {})
      ext_app_type = GraphEngine::ExtAppType.get_type_from_app_name(options[:ext_app_type])
      raise GraphEngine::Api::Exception.new("You have to supply a valid :ext_app_type") unless ext_app_type > 0

      user = GraphEngine::User.where(ext_app_type: ext_app_type, ext_user_id: options[:ext_user_id]).first
      user = GraphEngine::User.new(ext_app_type: ext_app_type, ext_user_id: options[:ext_user_id]) unless user

      user.email                         = options[:email]
      user.email                         = options[:email]
      user.username                      = options[:username]
      user.picture_url                   = options[:picture_url]
      user.fb_oauth_token                = options[:fb_oauth_token]
      user.fb_uid                        = options[:fb_uid]
      user.tw_oauth_token                = options[:tw_oauth_token]
      user.tw_oauth_secret               = options[:tw_oauth_secret]
      user.tw_uid                        = options[:tw_uid]
      user.fs_uid                        = options[:fs_uid]
      user.fs_access_token               = options[:fs_access_token]
      user.fs_oauth_token                = options[:fs_oauth_token]
      user.facebook_friend_ids           = options[:facebook_friend_ids]
      user.facebook_friend_of_friend_ids = options[:facebook_friend_of_friend_ids]
      user.twitter_friend_ids            = options[:twitter_friend_ids]
      user.foursquare_friend_ids         = options[:foursquare_friend_ids]

      user.save!

      user
    end
  end
end