require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    Like.create do |like|
      like.author = User.create do |user|
        user.name = 'John Doe'
        user.photo = 'https://picsum.photos/200'
        user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      end
      like.post = Post.create do |post|
        post.title = 'Post 1'
        post.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        post.author = User.create do |user|
          user.name = 'John Doe'
          user.photo = 'https://picsum.photos/200'
          user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        end
      end
    end
  end

  it 'likes_counter should be 1' do
    expect(subject.post.likes_counter).to eq(1)
  end
end
