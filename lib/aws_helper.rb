require 'sinatra/base'
require 'aws-sdk'

module Sinatra
  module AwsHelper
    def get_ec2(region, access_key, secret)
      credentials = new Aws::Credentials(access_key, secret)
      Aws::EC2::Resource.new(region: region, credentials: credentials)
    end
  end

  register AwsHelper
end
