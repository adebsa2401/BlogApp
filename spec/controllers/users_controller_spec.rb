require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns http success' do
      get users_path
      expect(response).to be_successful
      expect(response.body).to include('List of users')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let :user do
      User.create do |user|
        user.name = 'John Doe'
      end
    end

    it 'returns http success' do
      get user_path(user)
      expect(response).to be_successful
      expect(response.body).to include('User details')
      expect(response).to render_template(:show)
    end
  end
end
