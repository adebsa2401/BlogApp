require 'rails_helper'

RSpec.describe 'Users index page', type: :system do
  before do
    @user1 = User.create(
      name: 'User 1',
      photo: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png',
      bio: 'Bio 1'
    )
    @user2 = User.create(
      name: 'User 2',
      photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
      bio: 'Bio 2'
    )
    @user3 = User.create(
      name: 'User 3',
      photo: 'https://cdn.pixabay.com/photo/2018/10/30/07/56/lady-3783027__480.png',
      bio: 'Bio 3'
    )

    @user1.posts.create(title: 'Post 1', text: 'Body 1')

    @user2.posts.create(title: 'Post 2', text: 'Body 2')
    @user2.posts.create(title: 'Post 3', text: 'Body 3')

    @user3.posts.create(title: 'Post 4', text: 'Body 4')
    @user3.posts.create(title: 'Post 5', text: 'Body 5')
    @user3.posts.create(title: 'Post 6', text: 'Body 6')
  end

  it 'shows the username of each user' do
    visit users_path

    expect(page).to have_content('User 1')
    expect(page).to have_content('User 2')
    expect(page).to have_content('User 3')
  end

  it 'shows the profile picture of each user' do
    visit users_path

    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png']")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60']")
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2018/10/30/07/56/lady-3783027__480.png']")
  end

  it 'shows the number of posts written by each user' do
    visit users_path

    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content('Number of posts: 3')
  end

  it 'redirect to the user show page when the user card is clicked' do
    visit users_path
    click_on 'User 1'
    expect(page).to have_current_path(user_path(@user1))

    visit users_path
    click_on 'User 2'
    expect(page).to have_current_path(user_path(@user2))

    visit users_path
    click_on 'User 3'
    expect(page).to have_current_path(user_path(@user3))
  end
end
