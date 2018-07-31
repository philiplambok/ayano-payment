class LogSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at
end
