require 'spec_helper'

describe GraphEngine::FbPlace do
  describe "Index" do
    it "shold not save duplicate places based on the ext_fb_place_id" do
      places_ids = [1, 1, 1, 2, 3, 3, 3, 4]
      
      places_ids.each {|id| 
        GraphEngine::FbPlace.create(ext_fb_place_id: id)
      }
      GraphEngine::FbPlace.count.should == 4
    end
  end
end
