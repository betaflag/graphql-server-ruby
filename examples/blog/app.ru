require 'graphql'
require 'graphql_server'

require_relative 'models/comment'
require_relative 'models/post'
require_relative 'types/comment_type'
require_relative 'types/post_type'
require_relative 'types/query_type'
require_relative 'schema'

run GraphqlServer.new(schema: Schema)
