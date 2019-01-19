module Types
  class CommentType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :message, String, null: false
  end
end