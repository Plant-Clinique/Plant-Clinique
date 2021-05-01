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
end