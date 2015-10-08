class App < Sinatra::Base
  get '/' do
    # todo iterate regions
    ec2 = get_ec2(settings.aws_region, settings.aws_access_key, settings.aws_secret)
    get_status ec2
  end

  # get '/status' do
  # end
end
