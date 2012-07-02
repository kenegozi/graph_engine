module GraphEngine
  module Facebook
    class FriendsImporter
      attr_reader :user, :friends, :client

      def initialize(user)
        @user = user
        @friends = []
        @client = Facebook::Client.new({ fb_uid: user.fb_uid, fb_oauth_token: user.fb_oauth_token })
      end

      def import_friends
        user_friends = client.get_friends

        user_friends.each do |friend|
          get_or_create_user_from_friend(friend)
          add_friend_to_friends_list(friend)
        end

        user.save
      end

      def import_friends_of_friends
        user.facebook_friend_ids.uniq.each do |friend|
          friend_client = Facebook::Client.new({ fb_uid: friend, fb_oauth_token: user.fb_oauth_token })

          friend_client.get_friends.each do |friend_of_friend|
            # This is a must, since FB will block us if we create over the limit API-requests
            sleep(2) unless Rails.env.test?

            get_or_create_user_from_friend(friend_of_friend)
            add_friend_to_friends_of_friends_list(friend_of_friend)
          end
        end

        user.save
      end

      private
        def add_friend_to_friends_of_friends_list(friend)
          fb_uid = friend['id']
          user.facebook_friend_of_friend_ids << fb_uid unless user.facebook_friend_of_friend_ids.include?(fb_uid)
        end

        def add_friend_to_friends_list(friend)
          fb_uid = friend['id']
          user.facebook_friend_ids << fb_uid unless user.facebook_friend_ids.include?(fb_uid)
        end

        def get_or_create_user_from_friend(friend)
          user = User.where(fb_uid: friend['id']).first

          unless user
            user = User.new(ext_user_id: friend['id'], ext_app_type: ExtAppType::FACEBOOK, ext_display_name: friend['name'])
            user.save
          end
        end
    end
  end
end