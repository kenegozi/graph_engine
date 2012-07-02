require 'spec_helper'

describe User do
  subject { User.new }

  describe "Validations" do
    before(:each) do
      @valid_attributes = { ext_app_type: GraphEngine::ExtAppType::GOGOBOT, 
        ext_user_id: 1,
        ext_display_name: 'KensoDev',
        friends_count: 0,
        picture_url: 'http://cdn2.gbot.me/photos/VR/Ub/1332928797/Avi_Tzurel-20000000002710917-medium.jpg',
        email_enabled: true,
        email: 'avi@gogobot.com',
        username: 'kensodev' 
      }
    end

    it "should save the model correctly" do
      u = User.new(@valid_attributes)
      u.save.should be_true
    end

    it "should not save without ext_app_type" do
      u = User.new(@valid_attributes.merge({ext_app_type: ''}))
      u.save.should be_false
    end

    it "should not save without ext_user_id" do
      u = User.new(@valid_attributes.merge({ext_user_id: ''}))
      u.save.should be_false
    end
  end

  describe "gogobot_user?" do
    it "it should be true if the user is a gogobot user" do
      @user = Fabricate(:user)
      @user.gogobot_user?.should be_true
    end

    it "should be false if the user is not a gogobot user" do
      @user = User.new()
      @user.gogobot_user?.should be_false
    end
  end

  describe "Followers / Following" do
    before(:each) do
      @user = Fabricate(:user)
      @follower = Fabricate(:user)
      @followee = Fabricate(:user)
    end

    describe "following?" do
      it "should return false when I am not following a user" do
        @user.following?(@followee).should be_false
      end

      it "should return true when I am following a user" do
        @user.following << @followee.id
        @user.save

        @user.following?(@followee).should be_true
      end
    end
  end
end