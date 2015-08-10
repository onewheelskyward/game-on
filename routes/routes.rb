class App < Sinatra::Base
	get '/' do
		get_something
		erb :basic, :locals => {local_erb_var: 'xyz'}
	end

	get '/status' do
    get_status
    erb :status, :locals => {}
  end
end
