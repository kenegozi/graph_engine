require 'graph_engine/facebook/friends_importer'
require 'graph_engine/user'

describe GraphEngine::Facebook::FriendsImporter do

  subject { GraphEngine::Facebook::FriendsImporter }  

  before(:each) do
    @user = Fabricate("GraphEngine::User")
    @osher = Fabricate("GraphEngine::User", fb_uid: 639948152)
  end

  it "should have a user" do
    importer = subject.new(@user)
    importer.user.should == @user
  end

  it "should have friends" do
    importer = subject.new(@user)
    importer.friends.should == []
  end

  describe :import_friends do
    it "should create 2 more users from the users Facebook friends" do
      importer = subject.new(@user)
      importer.client.should_receive(:get_friends).and_return([
          {"name"=>"Ashim Chhabra", "id"=>"638960542"},
          {"name"=>"Osher Yadgar", "id"=>"639948152"},
          {"name"=>"Yair Wiener", "id"=>"640268580"}
        ])

      expect {
        importer.import_friends  
      }.to change{ GraphEngine::User.count }.by(2)
    end

    it "should add the fb_uids of the friends to the user friends array" do
      importer = subject.new(@user)

      importer.client.should_receive(:get_friends).and_return([
        {"name"=>"Ashim Chhabra", "id"=>"638960542"},
        {"name"=>"Osher Yadgar", "id"=>"639948152"},
        {"name"=>"Yair Wiener", "id"=>"640268580"}
      ])

      importer.import_friends
      @user.facebook_friend_ids.sort.should == ['638960542', '639948152', '640268580'].sort
    end
  end

  describe :import_friends_of_friends do
    before(:each) do
      @importer = subject.new(@user)
      @user.should_receive(:facebook_friend_ids).and_return([1490615109])

      client = double(:client)
      client.should_receive(:get_friends).and_return([
        {"name"=>"Meital Abramovich", "id"=>"100000527455016"}
      ])
      GraphEngine::Facebook::Client.should_receive(:new).and_return(client)
    end
    it "should create another user for the friends of friends" do
      expect {
        @importer.import_friends_of_friends  
      }.to change{ GraphEngine::User.count }.by(1)
    end
    it "should add the friends of friend to the user's friends_of_friends array" do
      @importer.import_friends_of_friends
      @user.facebook_friend_of_friend_ids.should == ['100000527455016']
    end
  end
end
# 
# {"name"=>"שמואל אלישע", "id"=>"100000570473388"}
# {"name"=>"Oren Todoros", "id"=>"100000790614527"}
# {"name"=>"Ran Bar-Zik", "id"=>"100000847860515"}
# {"name"=>"Erez Avny", "id"=>"100000897939998"}
# {"name"=>"ללה אלישע", "id"=>"100001406078173"}
# {"name"=>"Arieh Glazer", "id"=>"100001644001547"}
# {"name"=>"Avi Windriver", "id"=>"100001717021552"}
# {"name"=>"Roni Sh", "id"=>"100002494275920"}
# {"name"=>"Shira Bar-on Bier", "id"=>"100002726993527"}
# {"name"=>"Omry Nachman", "id"=>"100002728190448"}
# {"name"=>"Avi Assayag", "id"=>"100002840462640"}
# {"name"=>"Adrian Chang", "id"=>"100003343021532"}
# {"name"=>"Eli Elisha", "id"=>"100003606206335"}