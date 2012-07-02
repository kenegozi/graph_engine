module GraphEngine
  module Facebook
    class Client
      attr_reader :graph, :fb_uid
      
      # Public: Facebook client initializer.
      #
      # options - options hash
      #   fb_uid: Facebook User id
      #   fb_oauth_token: fb_oauth_token for the user
      #
      # Examples
      #
      #   @client = Facebook::Client.new(fb_uid: some_id, fb_oauth_token: some_token)
      # 
      def initialize(options = {})
        @fb_uid = options[:fb_uid]
        @graph = get_graph(options[:fb_oauth_token])
      end

      def get_friends
        get_connections "friends"
      end

      def get_checkins
        get_connections "checkins"
      end

      def get_likes
        get_connections "likes"
      end

      private
        def get_graph(token)
          Koala::Facebook::API.new token
        end

        def get_connections(connection_name)
          begin
            graph.get_connection(fb_uid, connection_name)
          rescue Exception => e
            
          end
        end
    end
  end
end