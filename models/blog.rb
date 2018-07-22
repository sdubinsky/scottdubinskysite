require 'pg'
class BlogModel
  def initialize
    @connection = PG.connect(ENV['DATABASE_URL'], dbname: 'postgres')
  end

  def get_posts
    posts = @connection.exec("SELECT id, title, substring(post from '\<p\>.+?\</p\>') as snippet, uploaded_date FROM blog")
    posts
  end

  def get_post title
    title = PG::Connection.escape_string title
    post = @connection.exec("SELECT * FROM blog WHERE title = '#{title}'").to_a
    post[0]
  end
end
