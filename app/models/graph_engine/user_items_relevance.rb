module GraphEngine
  class UserItemsRelevance
    include Mongoid::Document
    include Mongoid::Timestamps

    field :item_id, type: Integer
    field :relevance_score, type: Integer
    field :item_type, type: String
    field :facepile, type: Array

    field :gogobot_user_id, type: Integer
    field :world_region_id, type: Integer
    field :continent_id, type: Integer
    field :subcontinent_region_id, type: Integer
    field :country_id, type: Integer
    field :sub_national_region_id, type: Integer
    field :state_id, type: Integer
    field :province_area1_id, type: Integer
    field :province_area2_id, type: Integer
    field :province_area3_id, type: Integer
    field :city_id, type: Integer
    field :sublocality_id, type: Integer
    field :neighborhood_id, type: Integer
    field :place_id, type: Integer

    index([
      [:gogobot_user_id, Mongo::ASCENDING],
      [:user_id, Mongo::DESCENDING],
      [:place_id, Mongo::ASCENDING],
      [:city_id, Mongo::DESCENDING],
      [:country_id, Mongo::DESCENDING],
      [:world_region_id, Mongo::DESCENDING],
      [:continent_id, Mongo::DESCENDING],
      [:sub_national_region_id, Mongo::DESCENDING],
      [:state_id, Mongo::DESCENDING],
      [:province_area1_id, Mongo::DESCENDING],
      [:province_area2_id, Mongo::DESCENDING],
      [:province_area3_id, Mongo::DESCENDING],
      [:sublocality_id, Mongo::DESCENDING],
      [:neighborhood_id, Mongo::DESCENDING]
    ], name: "user_items_relevance_composite")
  end
end