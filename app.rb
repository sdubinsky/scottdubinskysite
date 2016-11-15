require 'sinatra'
require './models/milon'

get '/' do
  erb :index, locals: {current_page: "home"}
end
get '/home' do
  redirect("/")
end

get '/projects' do
  erb :projects, locals: {current_page: "projects"}
end

get '/resume' do
  erb :resume, locals: {current_page: "resume"}
end

get '/fencing' do
  erb :fencing, locals: {current_page: "fencing"}
end

get '/milon' do
  if params['verb']
    @translation = MilonModel.translate params['verb']
  end
  erb :milon
end
