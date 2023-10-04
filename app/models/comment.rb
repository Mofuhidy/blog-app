class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comments_counter
  after_destroy :decrease_comments_counter

  def decrease_comments_counter
    post.decrement!(:comments_counter)
  end
  
  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
