require_relative '../lib/aws_helper'

class App < Sinatra::Base
	def get_status
    ec2 = get_ec2(settings.aws_region, settings.aws_access_key, settings.aws_secret)
    instances = ec2.describe_instances().data

    instances.reservations.each do |reservation|
      reservation.instances.each do |instance|
        puts instance.instance_id
      end
    end
	end

  def get_ec2(region, access_key, secret)
    credentials = Aws::Credentials.new(access_key, secret)
    Aws::EC2::Client.new(region: region, credentials: credentials)
  end

end
