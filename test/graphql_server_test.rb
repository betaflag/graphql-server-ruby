require 'minitest/autorun'
require "minitest/spec"

require 'graphql_server'
require 'rack/test'
require 'hello_world_server'

describe GraphQLServer do
  include Rack::Test::Methods

  describe "app" do
    describe "#call" do
      let(:app) { HelloWorldServer.app }

      it 'responds to a graphql query via get' do
        get '/', {'query' => '{ hello }'}
        assert_equal 200, last_response.status
        expected_body = '{"data":{"hello":"world"}}'
        assert_equal expected_body, last_response.body
      end

      it 'responds to a graphql query via post' do
        post '/', {'query' => '{ hello }'}.to_json
        assert_equal 200, last_response.status
        expected_body = '{"data":{"hello":"world"}}'
        assert_equal expected_body, last_response.body
      end

      it 'does not support PUT queries' do
        put '/', {'query' => '{ hello }'}
        assert_equal 405, last_response.status
        assert_equal 'GraphQL Server supports only GET/POST requests', last_response.body
      end

      it 'does not support DELETE queries' do
        delete '/', {'query' => '{ hello }'}
        assert_equal 405, last_response.status
        assert_equal 'GraphQL Server supports only GET/POST requests', last_response.body
      end

      it 'returns error 400 when post body is missing' do
        post '/'
        assert_equal 400, last_response.status
        assert_equal 'POST body missing', last_response.body
      end
    end
  end

  describe "middleware" do
    describe "#call" do
      let(:app) { HelloWorldServer.middleware }

      it 'responds to a graphql query via get' do
        get '/', {'query' => '{ hello }'}
        assert_equal 200, last_response.status
        expected_body = '{"data":{"hello":"world"}}'
        assert_equal expected_body, last_response.body
      end
    end
  end
end
