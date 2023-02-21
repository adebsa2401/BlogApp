require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.create do |comment|
      comment.post = Post.create do |post|
        post.title = 'Post 1'
        post.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        post.author = User.create do |user|
          user.name = 'John Doe'
          user.photo = 'https://picsum.photos/200'
          user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        end
      end
      comment.author = User.create do |user|
        user.name = 'John Doe'
        user.photo = 'https://picsum.photos/200'
        user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      end
    end
  end

  it 'test update_comments_counter method' do
    expect(subject.post.comments_counter).to eq(1)

    Comment.create do |comment|
      comment.post = subject.post
      comment.author = subject.author
      comment.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    end

    expect(subject.post.comments_counter).to eq(2)
  end
end
