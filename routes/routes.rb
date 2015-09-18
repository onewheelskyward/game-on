class App < Sinatra::Base
	get '/' do

		ec2 = get_status
		erb :status, :locals => {ec2: ec2}
	end

	# get '/status' do
  # end
end
