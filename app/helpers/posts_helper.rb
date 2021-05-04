module PostsHelper
  def get_topic_in_display_format(topic)
    topic.capitalize.gsub(/[^0-9A-Za-z]/, ' ')
  end

  def not_all_posts_are_displayed
    @all_topic_posts.length < @all_posts.length && !@current_page_posts.all.empty?
  end

  def no_posts_in_this_topic
    @current_page_posts.first.nil?
  end

  def get_current_topic
    get_topic_in_display_format(@topics.keys[@current_page_posts.first.topic])
  end

  def get_topic_from_id(topic_id)
    get_topic_in_display_format(Post.topics.keys[topic_id])
  end
end
