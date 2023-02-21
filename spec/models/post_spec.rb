require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.create do |post|
      post.title = 'Post 1'
      post.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      post.author = User.create do |user|
        user.name = 'John Doe'
        user.photo = 'https://picsum.photos/200'
        user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      end
    end
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be less than or equal to 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent_comments method should return the 5 most recent comments' do
    15.times do |i|
      Comment.create do |comment|
        comment.text = "Comment #{i}"
        comment.author = User.create do |user|
          user.name = "John Doe #{i}"
          user.photo = 'https://picsum.photos/200'
          user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        end
        comment.post = subject
      end
    end

    expect(subject.recent_comments.count).to eq(5)
    expect(subject.recent_comments.first.text).to eq('Comment 14')
    expect(subject.recent_comments.last.text).to eq('Comment 10')
  end
end
