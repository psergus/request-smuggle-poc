# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'
require "sinatra"
require "sinatra/json"
require 'logger'

set :port, 80
set :bind, '0.0.0.0'

class AppLogger < Logger
  class << self
    extend Forwardable

    def create_instance
      new(STDERR)
    end

    def instance
      @instance ||= create_instance
    end

    def_delegators :instance, :info, :fatal, :error, :debug, :warn, :color
  end
end
  logger = Logger.new(STDOUT)

def ol_headers(env)
  env.select do |key, _|
    key.to_s.match(/^HTTP_X_/)
  end.each do |key, value|
    AppLogger.info "Header: #{key} => #{value}"
  end
end

post "/api/v1/test" do
  ol_headers(request.env)
  "API v1 is here"
end

post "/api/v2/test" do
  ol_headers(request.env)
  json :key1 => 'value1', :key2 => 'value2'
end

get "/robots" do
  redirect "/"
end
