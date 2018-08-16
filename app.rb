require 'sinatra'
require 'sequel'

configure :development do
  set :show_exceptions, true
end
connstr = ENV['DATABASE_URL'] || "postgres://localhost/sdubinskysite"
DB = Sequel.connect connstr
require './models/init'
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
  erb :milon, locals: {current_page: "milon"}
end

get '/blog/?:id?' do
  begin
    if params[:id]
      @post = Post[params[:id].to_i]
      redirect to("/blog") unless @post
      
      View.create(
        post: @post,
        timestamp: Time.now.to_i,
        viewer_ip: request.ip
      ).save
      erb :post, locals: {current_page: "blog"}
      
    else
      @blogposts = Post.order_by(:timestamp).reverse
      erb :posts, locals: {current_page: "blog"}
    end
  rescue ::PG::Error => e
    puts e
    redirect to("/")
  end
end

not_found do
  print "not found"
  redirect to("/")
end
