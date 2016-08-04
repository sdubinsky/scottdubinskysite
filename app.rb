require 'sinatra'
require './models/milon'

get '/' do
  erb :index
end

get '/projects' do
  erb :projects
end

get '/resume' do
  erb :resume
end

get '/fencing' do
  erb :fencing  
end

get '/milon' do
  if params['verb']
    @translation = MilonModel.translate params['verb']
  end
  erb :milon
end
