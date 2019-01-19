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

use GraphqlServer, type_def: type_def, resolver: resolver, path: '/graphql'
run ->(env) { [200, {"Content-Type" => "text/html"}, ["Hello World!"]] }
