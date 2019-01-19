Gem::Specification.new do |s|
  s.name        = 'graphql_server'
  s.version     = '0.0.1'
  s.date        = '2019-01-18'
  s.summary     = "A simple spec-compliant GraphQL rack application and middleware"
  s.description = "A simple spec-compliant GraphQL rack application and middleware"
  s.authors     = ["betaflag"]
  s.email       = 'hello@betaflag.com'
  s.files       = ["README.md", "lib/graphql_server.rb"]
  s.test_files  = s.files.select { |p| p =~ /^test\/.*_test.rb/ }
  s.homepage    = 'https://github.com/betaflag/graphql-server-ruby'
  s.license     = 'MIT'
  
  s.add_dependency 'rack', '~> 2.0'
  s.add_dependency 'graphql', '~> 1.8.13'
  s.add_dependency 'json', '~> 1.8.6'
end
