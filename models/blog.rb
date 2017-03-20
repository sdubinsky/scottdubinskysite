require 'pg'
class BlogModel
  def initialize
    @connection = PG.connect(ENV['DATABASE_URL'])
  end

  def get_posts
    posts = @connection.exec("SELECT id, title, substring(post from '\<p\>.+?\</p\>') as snippet FROM blog")
    posts
  end

  def get_post title
    post = @connection.exec("SELECT * FROM blog WHERE title = '#{title}'").to_a
    post[0]
  end
end
