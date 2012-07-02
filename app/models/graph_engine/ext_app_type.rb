module GraphEngine
  class ExtAppType
    GOGOBOT     = 1
    FACEBOOK    = 2
    TWITTER     = 3
    FOURSQUARE  = 4

    # Public: Gets the correct app type from the name of the app.
    #
    # app_name - the name of the app you want to get the id for
    # 
    # Examples
    #
    #   ExtAppType.get_type_from_app_name('Gogobot')
    #   # => ExtAppType::GOGOBOT
    #
    # Returns the duplicated String.
    def self.get_type_from_app_name(app_name)
      begin
        "ExtAppType::#{app_name.upcase}".constantize
      rescue Exception => e
        0
      end
    end  
  end
end