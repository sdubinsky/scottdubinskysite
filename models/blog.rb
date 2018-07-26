require 'pg'
class BlogModel
  def initialize
    @connection = PG.connect(ENV['DATABASE_URL'])
  end

  def get_posts
    posts = @connection.exec("SELECT id, title, substring(post from '\<p\>.+?\</p\>') as snippet, uploaded_date FROM blog ORDER BY uploaded_date DESC")
    posts
  end

  def get_post id
    id = PG::Connection.escape_string id
    post = @connection.exec("SELECT * FROM blog WHERE id = '#{id}'").to_a
    post[0]
  end
end
