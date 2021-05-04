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
  def self.get_related_posts(plants)
    related_posts = [] # an array of related posts 
    plants.each do |plant|
      plant_type = PlantType.where(trefle_id: plant.plant_type).first.name
      Post.all.each do |post|
        if post.body.downcase.include?(plant_type.downcase) or post.title.downcase.include?(plant_type.downcase)
          related_posts << post
        end
      end
    end
    return related_posts
  end
end