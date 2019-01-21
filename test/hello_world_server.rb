class HelloWorldServer
  class << self
    def app
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

      Rack::Builder.new do
        run GraphQLServer.new(type_def: type_def, resolver: resolver)
      end
    end

    def middleware(path = nil)
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

      Rack::Builder.new do
        use GraphQLServer, type_def: type_def, resolver: resolver
        run [200]
      end
    end
  end
end