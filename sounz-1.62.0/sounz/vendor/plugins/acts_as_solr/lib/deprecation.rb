module ActsAsSolr
  
  class Post
    def initialize(body, mode = :search)
      @body = body
      @mode = mode
      puts "The method ActsAsSolr::Post.new(body, mode).execute_post is depracated " +
           "and will be obsolete by version 1.0. Use ActsAsSolr::Post.execute(body, mode) instead!"
    end
    
    def execute_post
      ActsAsSolr::Post.execute(@body, @mode)
    end
  end

end