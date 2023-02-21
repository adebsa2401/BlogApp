class User < ApplicationRecord
  has_many :comments, inverse_of: :author
  has_many :likes, inverse_of: :author
  has_many :posts, inverse_of: :author

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
