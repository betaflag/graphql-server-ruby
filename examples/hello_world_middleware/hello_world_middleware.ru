require 'graphql_server'

type_def = <<-GRAPHQL
  type Query {
    hello: String
  }
GRAPHQL

resolver = {
  "Query" => { 
    "hello" => Proc.new { "world" }
  }
}

map '/graphql' do
  use GraphQLServer, type_def: type_def, resolver: resolver
end

run ->(env) { [200, {"Content-Type" => "text/html"}, ["Hello World!"]] }
