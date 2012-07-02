module GraphEngine
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include GraphEngine::FacebookUser

    field :followers, :type => Array, :default => []
    field :following, :type => Array, :default => []

    field :facebook_friend_ids, :type => Array, :default => []
    field :facebook_friend_of_friend_ids, :type => Array, :default => []
    field :twitter_friend_ids, :type => Array, :default => []
    field :foursquare_friend_ids, :type => Array, :default => []
    field :items_relevance, :type => Array, :default => []

    field :ext_app_type, type: Integer
    field :ext_user_id, type: Integer
    field :ext_display_name
    field :picture_url
    field :friends_count, type: Integer, default: 0
    field :email_enabled, type: Boolean, default: false

    field :email
    field :username

    # Auth fields (Facebook)
    field :fb_oauth_token
    field :fb_uid, type: Integer

    # Auth fields (Twitter)
    field :tw_uid
    field :tw_oauth_token
    field :tw_oauth_secret

    # Auth fields (Foursquare)
    field :fs_uid
    field :fs_access_token
    field :fs_access_secret
    field :fs_oauth_token

    index(
      [
        [ :ext_user_id, Mongo::ASCENDING ],
        [ :ext_app_type, Mongo::ASCENDING ]
      ],
      unique: true,
      background: true
    )

    index :fb_uid, unique: true, sparse: true
    index :fs_uid, unique: true, sparse: true
    index :tw_uid, unique: true, sparse: true
    index :facebook_friend_ids, background: true
    index :facebook_friend_of_friend_ids, background: true
    index :twitter_friend_ids, background: true
    index :foursquare_friend_ids, background: true
    index :following, background: true
    index :followers, background: true

    validates_presence_of :ext_app_type, :ext_user_id

    def toggle_follow!(user)
      
    end

    def following?(user)
      following.include? user.id
    end

    def gogobot_user?
      self.ext_app_type == GraphEngine::ExtAppType::GOGOBOT && self.ext_user_id.to_i > 0
    end

    def facebook_user?
      self.fb_uid.to_i > 0
    end
  end
end