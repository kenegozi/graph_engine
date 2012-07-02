require 'graph_engine/api/user'
require 'graph_engine/api/exception'

describe GraphEngine::Api::User do
  describe :create do
    before(:each) do
      @valid_hash = {
        gogobot_user_id: 1,
        ext_app_type: 'gogobot',
        ext_user_id: 1,
        email: 'avi@kensodev.com',
        username: 'KensoDev'
      }
    end
    
    it "should throw an exception when you don't pass a valid ext_app_type" do
      expect {
        GraphEngine::Api::User.create(@valid_hash.merge({ ext_app_type: nil }))
      }.to raise_error(GraphEngine::Api::Exception)
    end

    it "should be valid" do
      GraphEngine::Api::User.create(@valid_hash)
      GraphEngine::User.count.should == 1
    end
  end
end