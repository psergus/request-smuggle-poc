# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'
require "sinatra"
require 'logger'
require 'httparty'
require 'faraday'

set :port, 80
set :bind, '0.0.0.0'

class CustomHttp
  include HTTParty

  headers 'Content-Type' => 'application/json'
  format :json
  base_uri 'http://api-service'

  def test_call
    body = { :payload => 'test' }.to_json
    self.class.post("/api/v2/test", :body => body)
  end
end

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

def make_call
  api_service = "http://api-service/api/v1/test"
  response = HTTParty.post(api_service,
    :body => { :payload => 'payload' },
    :headers => { 'Content-Type' => 'application/json' } )
  AppLogger.info response.inspect
end

def make_api_call
  response = CustomHttp.new.test_call
  AppLogger.info response.inspect
end

def make_farday_call
  conn = Faraday.new(:url => 'http://api-service')
  response = conn.post '/api/v1/test'
end

get "/" do
  ol_headers(request.env)
  make_call
  make_api_call
  make_farday_call
  "Hello there!"
end

get "/robots" do
  redirect "/"
end
