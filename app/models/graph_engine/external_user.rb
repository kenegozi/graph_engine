module GraphEngine
  class ExternalUser
    include Mongoid::Document
    include Mongoid::Timestamps

    field :ext_app_type, :type => String
    field :ext_user_id, :type => String
    field :display_name, :type => String

    index(
      [
        [ :ext_user_id, Mongo::ASCENDING ],
        [ :ext_app_type, Mongo::ASCENDING ]
      ],
      unique: true,
      background: true
    )
  end
end