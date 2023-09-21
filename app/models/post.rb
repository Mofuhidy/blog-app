class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250, too_long: "Characters should be less than 250 character" }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }  
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }  

  after_save :update_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:post_counter)
  end
end
