require 'graphql'
require 'json'
require 'rack'

class GraphqlServer
  class InvalidRequestTypeError < Exception; end;
  class PostBodyMissing < Exception; end;

  # Initilizes GraphqlServer as a Rack app or middleware
  #
  # This Rack middleware (or app) implements a spec-compliant GraphQL server which can be queried from any GraphQL client.
  # It can be used with a provided GraphQL schema or can build one from a type definition and a resolver hash.
  #
  # @param [Array<Object>] *args The first argument should be `app` when used as a middleware
  # @param String path Also for middleware, we will use path to determine when to process GraphQL, defaults to '/'
  # @param String type_def A schema definition string, or a path to a file containing the definition
  # @param Hash resolver A hash with callables for handling field resolution
  # @param GraphQL::Schema schema Use this schema if `type_def` and `resolver` is nil
  # @param Hash context
  def initialize(*args , path: nil, type_def: nil, resolver: nil, schema: nil, context: nil)
    @app = args && args[0]
    @context = context
    @path = (@app && !path) ? '/' : path
    @schema = type_def && resolver ? GraphQL::Schema.from_definition(type_def, default_resolve: resolver) : schema
  end

  def middleware?
    !@app.nil?
  end

  def call(env)
    request = Rack::Request.new(env)

    # only resolve when url matches `path` if we're in a middleware
    return @app.call(env) if middleware? && @path != request.path_info
    
    # graphql accepts GET and POST requests
    raise InvalidRequestTypeError unless request.get? || request.post?

    payload = if request.get?
      request.params
    elsif request.post?
      body = request.body.read
      raise PostBodyMissing if body.empty?
      payload = JSON.parse(body)
    end

    response = @schema.execute(
      payload['query'], 
      variables: payload['variables'],
      operation_name: payload['operationName'],
      context: @context, 
    ).to_json
    
    [200, {'Content-Type' => 'application/json', 'Content-Length' => response.bytesize.to_s}, [response]]
  rescue InvalidRequestTypeError
    # Method Not Allowed
    [405, {"Content-Type" => "text/html"}, ["GraphQL Server supports only GET/POST requests"]]
  rescue PostBodyMissing
    # Bad Request
    [400, {"Content-Type" => "text/html"}, ["POST body missing"]]
  end
end
