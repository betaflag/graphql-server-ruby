class Post < OpenStruct  
  def self.find(id)
    Post.new(
      id: 1, 
      title: 'first post', 
      truncated_preview: 'Hello world!', 
      comments: [
        Comment.new(id: 1, message: 'first comment')
      ]
    )
  end
end