require 'pg'
class BlogModel
  def initialize
    @connection = PG.connect(dbname: 'postgres')
  end

  def get_posts
    posts = @connection.exec("SELECT id, title, substring(post from '\<p\>.+?\</p\>') as snippet FROM blog")
    posts
  end

  def get_post id
    post = @connection.exec("SELECT * FROM blog WHERE id = #{id}").to_a
    post[0]
  end
end
