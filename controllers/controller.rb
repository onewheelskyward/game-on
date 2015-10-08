require_relative '../lib/aws_helper'

class App < Sinatra::Base
  def get_status(ec2)
    instances = get_instances ec2
    volumes = get_volumes ec2
    images = get_images ec2
    # snapshots = get_snapshots(ec2)

    # ec2.request
    ec2
  end

  def get_snapshots(ec2)
    snapshots = ec2.describe_snapshots.data
    snapshot_list = []
    snapshots.snapshots.each do |snapshot|
      puts "#{snapshot.description}"
      snapshot_list.push snapshot
    end
    snapshot_list
  end

  def get_images(ec2)
    images = ec2.describe_images({"image_ids": ["ami-dc35d0ef"]}).data
    image_list = []
    images.images.each do |image|
      puts "Image #{image.description}"
      image_list.push image
    end
    image_list
  end

  def get_volumes(ec2)
    volumes = ec2.describe_volumes.data
    volume_list = []
    volumes.volumes.each do |volume|
      puts "Volume: #{volume.volume_id} #{volume.size} #{volume.availability_zone}"
      volume_list.push volume
    end
    volume_list
  end

  def get_instances(ec2)
    instances = ec2.describe_instances.data
    instance_list = []

    instances.reservations.each do |reservation|
      reservation.instances.each do |instance|
        puts "Instance: #{instance.instance_id}"
        instance_list.push instance
      end
    end
    instance_list
  end

  def get_ec2(region, access_key, secret)
    credentials = Aws::Credentials.new(access_key, secret)
    Aws::EC2::Client.new(region: region, credentials: credentials)
  end

end
