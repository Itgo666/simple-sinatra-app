require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'

require 'active_record'
require 'yaml'
require 'json'

require './tools/tl_rsp'

class BaseApp < Sinatra::Base
  include Ns::TlRsp

  # Register custom extensions

  configure :development do
    register Sinatra::Reloader
  end

  # Configure ActiveRecord

  env    = ENV['ENV'] || 'development'
  root   = File.expand_path '..', __FILE__
  config = YAML.load(File.read(File.join(root, 'db/config.yml')))

  ActiveRecord::Base.configurations = config
  ActiveRecord::Base.establish_connection env.to_sym

  # Create @body variable

  before do
    if request.content_length.to_i > 0
      request.body.rewind
      @body = JSON.parse request.body.read, symbolize_names: true
    end
  end

end

Dir.glob("./models/*.rb").sort.each do |file|
  require file
end

Dir.glob("./apps/*.rb").sort.each do |file|
  require file
end


map('/') { run RootApp}
map('/user') { run UserApp}
map('/info') { run InfoApp}
