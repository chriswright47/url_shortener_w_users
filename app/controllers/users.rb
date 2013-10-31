
enable :sessions

get '/' do
  # Look in app/views/index.erb
  # redirect '/secret' if session[:signed_in]
  erb :index
end

post '/' do
  if User.authenticate(params[:email], params[:password])
    session[:signed_in] = true
    session[:user_id] = User.find_by_email(params[:email]).id
    redirect '/secret'
  else
    redirect '/create_account'
  end 
end



get '/create_account' do
  erb :create_account
end

post '/create_account' do
  User.create!(email: params[:email], password: params[:password])
  session[:signed_in] = true
  session[:user_id] = User.find_by_email(params[:email]).id
  redirect '/'
end

get '/secret' do
  erb :secret
end

post '/sign_in' do
  redirect '/secret' if session[:signed_in]
  erb :index

end


post '/urls' do
  Url.create!(long_url: params[:long_url], user_id: session[:user_id])
  redirect '/'
end

get '/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  redirect "#{url.long_url}"
end

get '/users/:id' do
  @id = params[:id]
  erb :profile
end

post '/logout' do
  session.clear
  redirect '/'
end
