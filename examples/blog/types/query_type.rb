module Types
  class QueryType < GraphQL::Schema::Object
    description "The query root of this schema"

    # First describe the field signature:
    field :post, Types::PostType, null: true do
      description "Find a post by ID"
      argument :id, ID, required: true
    end

    # Then provide an implementation:
    def post(id:)
      Post.find(id)
    end
  end
end
