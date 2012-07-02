module GraphEngine
  class FbPlace
    include Mongoid::Document
    
    field :name
    field :ext_fb_place_id, type: Integer
    field :street
    field :city
    field :state
    field :country
    field :zip
    field :lat, type: Float
    field :lng, type: Float
    field :entry_json
    field :city_id, type: Integer
    field :item_id, type: Integer
    field :item_type
    field :ignore, type: Boolean, default: false

    index :ext_fb_place_id, unique: true
    index :item_id
    index :city_id
  end
end