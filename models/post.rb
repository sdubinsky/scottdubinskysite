class Post < Sequel::Model
  one_to_many :views

  def snippet
    DB.fetch("select substring(post from '\<p\>.+?\</p\>') as snippet from posts where id=#{id} limit 1").first[:snippet]
  end
end
