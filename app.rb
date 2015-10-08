require 'sinatra/base'
# require 'data_mapper'
# require 'dm-sqlite-adapter'
require 'sinatra/config_file'
require_relative 'lib/aws_helper'

# require 'dm-postgres-adapter'

# DataMapper::Logger.new($stdout, :debug)
# DataMapper::Property::String.length(4000)
# DataMapper.setup(:default, "sqlite://#{File.expand_path(File.dirname(__FILE__))}/sample.sqlite")
# DataMapper.setup(:default, "postgres://localhost/square-peg")

class App < Sinatra::Base
  helpers Sinatra::Helpers
  register Sinatra::AwsHelper
  register Sinatra::ConfigFile
  config_file 'config/config.yml'

  # ec2 = get_ec2(settings.aws_region, settings.aws_access_key, settings.aws_secret)
  # ec2 =

  app_folders = %w(models helpers controllers routes)
  # Require our ruby fileses
  app_folders.each do |folder|
    Dir.glob("#{folder}/*.rb").each { |file| require_relative file }
  end

  # DataMapper.finalize
  # DataMapper.auto_upgrade!
  # DataMapper.auto_migrate!  # This one wipes the database out every time.  Good for testing.

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
    app_folders.each do |folder|
      Dir.glob("#{folder}/*.rb").each { |file| also_reload file }
    end
  end
end
