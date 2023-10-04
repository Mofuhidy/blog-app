class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments,  dependent: :destroy
  has_many :likes,  dependent: :destroy

  validates :title, presence: true, length: { maximum: 250, too_long: 'Characters should be less than 250 character' }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :decrease_posts_counter
  after_initialize :set_default

  def set_default
    self.likes_counter ||= 0
    self.comments_counter ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end 
  
  def decrease_posts_counter
    author.decrement!(:posts_counter)
  end
end
