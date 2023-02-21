require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.create do |user|
      user.name = 'John Doe'
      user.photo = 'https://picsum.photos/200'
      user.bio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    end
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent_posts method should return the 3 most recent posts' do
    5.times do |i|
      Post.create do |post|
        post.title = "Post #{i}"
        post.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        post.author = subject
      end
    end

    expect(subject.recent_posts.count).to eq(3)
    expect(subject.recent_posts.first.title).to eq('Post 4')
    expect(subject.recent_posts[1].title).to eq('Post 3')
    expect(subject.recent_posts.last.title).to eq('Post 2')
  end
end
