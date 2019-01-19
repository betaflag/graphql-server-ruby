This is a simple spec-compliant GraphQL rack application and middleware based on the [graphql](https://github.com/rmosolgo/graphql-ruby) gem. Since it's built with Rack, it can be mounted with most ruby web servers.

Install the gem:

```
gem install graphql_server
```

# Using the server

## As a standalone application

```ruby
# app.ru
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

run GraphqlServer.new(type_def: type_def, resolver: resolver)
```

Start using `rackup`

```
rackup app.ru
```

## As a middleware in your existing application

```ruby
# app.ru
require 'graphql_server'

type_def = ...
resolver = ...

use GraphqlServer, type_def: type_def, resolver: resolver, path: '/graphql'
```

# Options

## Schema

You can get started fast by writing a type defintions and a resolver hash

```ruby
GraphqlServer.new(type_def: type_def, resolver: resolver)
```

You can also provide your own [schema](http://graphql-ruby.org/schema/definition.html)

```ruby
GraphqlServer.new(schema: schema)
```

See the examples folder for more details

## Middleware

When using as a middleware, you can specify the path to mount the graphql endpoint (defaults to `/`)

```ruby
use GraphqlServer, type_def: type_def, resolver: resolver, path: '/graphql'
```
