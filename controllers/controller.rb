require_relative '../lib/aws_helper'

class App < Sinatra::Base
	def get_status
    ec2 = get_ec2(settings.aws_region, settings.aws_access_key, settings.aws_secret)
    instances = ec2.describe_instances.data

    instances.reservations.each do |reservation|
      reservation.instances.each do |instance|
        puts "Instance: #{instance.instance_id}"
      end
    end

    volumes = ec2.describe_volumes.data
    volumes.volumes.each do |volume|
      puts "Volume: #{volume.volume_id} #{volume.size} #{volume.availability_zone}"
    end

    snapshots = ec2.describe_snapshots.data
    snapshots.snapshots.each do |snapshot|
      puts "#{snapshot.description}"
    end

    ec2.request
    ec2
	end

  def get_ec2(region, access_key, secret)
    credentials = Aws::Credentials.new(access_key, secret)
    Aws::EC2::Client.new(region: region, credentials: credentials)
  end

end
