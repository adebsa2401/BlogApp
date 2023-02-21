class User < ApplicationRecord
  has_many :comments, inverse_of: :author
  has_many :likes, inverse_of: :author
end
