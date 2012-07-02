module GraphEngine
  class FbCheckin
    include Mongoid::Document
    include Mongoid::Timestamps

    field :application_name
    field :application_id, type: Integer
    field :ext_fb_checkin_id, type: Integer
    field :ext_fb_place_id, type: Integer
    field :lat, type: Float
    field :lng, type: Float
    field :fb_uid, type: Integer
    field :entry_json
    field :ignore, type: Boolean
    field :is_realtime, type: Boolean

    index :fb_uid

    def fb_place
      GraphEngine::FbPlace.where(ext_fb_place_id: ext_fb_place_id).first
    end
  end
end