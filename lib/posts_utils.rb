class PostsUtils
  ORDERS = ["Newest", "Oldest", "Most Popular", "Least Popular"].freeze
  def self.posts_sort(list, order)
    if order && order == "Oldest"
      list.ordered_by_oldest
    elsif order == "Most Popular"
      list.ordered_by_most_replies
    elsif order == "Least Popular"
      list.ordered_by_least_replies
    else
      list.ordered_by_newest
    end
  end

  def self.get_related_posts(plants, max_amount_of_posts)
    related_posts = [] # an array of related posts 
    plant_types = plants.map { |plant| PlantType.where(trefle_id: plant.plant_type).first.name }
    Post.ordered_by_newest.all.each do |post|
      if plant_types.any? { |plant_type| post.body.downcase.include?(plant_type.downcase) || post.title.downcase.include?(plant_type.downcase)}
        related_posts << post
      end
      break if related_posts.length >= max_amount_of_posts
    end
    return related_posts
  end
end