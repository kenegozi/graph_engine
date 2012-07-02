module GraphEngine
  module FacebookUser
    extend ActiveSupport::Concern

    def fb_importer
      @fb_importer ||= Facebook::FriendsImporter.new(self)
    end

    def fb_import_friends
      fb_importer.import_friends
    end

    def fb_import_friends_of_friends
      fb_importer.import_friends_of_friends
    end
  end
end