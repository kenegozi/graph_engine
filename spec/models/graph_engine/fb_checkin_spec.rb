require 'spec_helper'

describe GraphEngine::FbCheckin do
  describe "fb_place" do
    before(:each) do
      @fb_place = Fabricate("GraphEngine::FbPlace")
    end

    it "should point to the correct place" do
      fb_checkin = GraphEngine::FbCheckin.new(ext_fb_place_id: @fb_place.ext_fb_place_id)
      fb_checkin.fb_place.should == @fb_place
    end
  end
end
