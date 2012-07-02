require 'spec_helper'

describe GraphEngine::ExtAppType do
  it "should return the correct ext_app_type" do
    ext_app_types_words = ["Gogobot", "Facebook", "Twitter", "Foursquare"]
    [GraphEngine::ExtAppType::GOGOBOT, GraphEngine::ExtAppType::FACEBOOK, GraphEngine::ExtAppType::TWITTER, GraphEngine::ExtAppType::FOURSQUARE].each_with_index do |ext_app_type, index|
      GraphEngine::ExtAppType.get_type_from_app_name(ext_app_types_words[index]).should eq(ext_app_type)
    end
  end

  it "sGraphEnginehould return 0 when the app is invalid" do
    GraphEngine::ExtAppType.get_type_from_app_name("SomeAppWeDontHave").should eq(0)
  end
end