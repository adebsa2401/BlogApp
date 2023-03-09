require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    let :user do
      User.create do |user|
        user.name = 'John Doe'
      end
    end

    it 'returns http success' do
      get user_posts_path(user)
      expect(response).to be_successful
      expect(response.body).to include('Posts')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let :user do
      User.create do |user|
        user.name = 'John Doe'
      end
    end

    let :post do
      Post.create do |post|
        post.title = 'Post 1'
        post.text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        post.author = user
      end
    end

    it 'returns http success' do
      get user_post_path(user, post)
      expect(response).to be_successful
      expect(response.body).to include(post.title)
      expect(response).to render_template(:show)
    end
  end
end
