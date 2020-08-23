require 'sinatra'
require 'sequel'
require 'psych'

configure :development do
  set :show_exceptions, true
end
if  ENV["DATABASE_URL"]
  db_address = ENV["DATABASE_URL"]
else
  config = Psych.load_file("./config.yml")
  db_config = config['database']
  if db_config['db_username'] or db_config['db_password']
    login = "#{db_config['db_username']}:#{db_config['db_password']}@"
  else
    login = ''
  end
  db_address = "postgres://#{login}#{db_config['db_address']}/#{db_config['db_name']}"
end
DB = Sequel.connect db_address
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

get '/blog/rss' do
  content_type 'text/xml'
  @posts = Post.order_by(:timestamp).reverse
  erb :rss, layout: false
end

get '/blog/?:id?' do
  begin
    if params[:id]
      @post = Post[params[:id].to_i]
      redirect to("/blog") unless @post
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

post '/submit-comment' do
  Comment.create(
    post_id: params['post-id'],
    username: params['comment-form-username'],
    title: params['comment-form-title'],
    text: params['comment-form-body'],
    created_date: Time.now.to_i
  )
  redirect "/blog/#{params['post-id']}"
end

post '/logging/?' do
  country_code = env['HTTP_CF_IPCOUNTRY']
  viewer_ip = env['HTTP_CF_CONNECTING_IP']
  body = JSON.parse(@request.body.read)
  View.create(
    endpoint: body['endpoint'],
    timestamp: Time.now.to_i,
    country_code: country_code,
    viewer_ip: viewer_ip
  )
end

not_found do
  print "not found"
  redirect to("/")
end
