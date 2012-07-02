require 'spec_helper'

describe GraphEngine::Facebook::Client do
  let(:user) { Fabricate.build('GraphEngine::FacebookUser') }
  subject { GraphEngine::Facebook::Client }
  let(:client) { subject.new({ fb_uid: user.fb_uid, fb_oauth_token: user.fb_oauth_token }) }
  
  it "should init with an fb_uid and return the same fb_uid", :vcr do
    VCR.use_cassette('facebook/client/user') do
      client.fb_uid.should eq(user.fb_uid)
    end
  end

  it "should return the graph object", :vcr do
    VCR.use_cassette('facebook/client/graph') do
      client.graph.should_not be_nil
    end
  end

  describe :get_friends do
    it "should return the list of friends for the user", :vcr do
      VCR.use_cassette('facebook/client/get_friends') do
        client.get_friends.length.should > 0
      end
    end

    it "should grab friends for a friend of the user" do
      VCR.use_cassette('facebook/client/get_friends_for_friend_of_user') do
        client = subject.new({ fb_uid: 1490615109, fb_oauth_token: user.fb_oauth_token })
        client.get_friends.length.should > 0
      end
    end
  end

  describe :get_checkins do
    it "should return the list of checkins for the user", :vcr do

      VCR.use_cassette('facebook/client/get_checkins') do
        client.get_checkins.length.should > 0
      end
    end
  end

  describe :get_likes do
    it "should return the list of likes for the user", :vcr do
      VCR.use_cassette('facebook/client/get_likes') do
        client.get_likes.length.should > 0
      end
    end
  end
end