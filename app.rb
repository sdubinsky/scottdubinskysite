require 'sinatra'
require './models/milon'
require './models/blog'

set :show_exceptions, true

get '/' do
  erb :index, locals: {current_page: "home"}
end
get '/home/?' do
  redirect("/")
end

get '/projects/?' do
  erb :projects, locals: {current_page: "projects"}
end

get '/resume/?' do
  erb :resume, locals: {current_page: "resume"}
end

get '/fencing/?' do
  erb :fencing, locals: {current_page: "fencing"}
end

get '/milon/?' do
  if params['verb']
    @translation = MilonModel.translate params['verb']
  end
  erb :milon
end

get '/posts/?:id?' do
  @blog = BlogModel.new()
  if params[:id]
    @post = @blog.get_post params[:id]
    erb :post, locals: {current_page: "blog"}    
  else
    @blogposts = @blog.get_posts
    erb :posts, locals: {current_page: "blog"}
  end

end

not_found do
  print "not found"
  redirect("/")
end
