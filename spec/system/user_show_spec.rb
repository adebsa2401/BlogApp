require 'rails_helper'

RSpec.describe "User show page", type: :system do
  before do
    @user = User.create(
      name: 'Username',
      photo: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png',
      bio: 'Bio'
    )

    @user.posts.create(title: 'Post 1', text: 'Body 1')
    @user.posts.create(title: 'Post 2', text: 'Body 2')
    @user.posts.create(title: 'Post 3', text: 'Body 3')
  end

  it 'shows the user name' do
    visit user_path(@user)
    expect(page).to have_content('Username')
  end

  it 'shows the user photo' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png']")
  end

  it 'shows the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 3')
  end

  it 'shows the user bio' do
    visit user_path(@user)
    expect(page).to have_content('Bio')
  end

  it 'shows the user first 3 posts' do
    visit user_path(@user)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  it 'shows a button that lets view all of a user\'s posts' do
    visit user_path(@user)
    expect(page).to have_link('See all posts')
  end

  it 'redirects to the user posts index page when the button is clicked' do
    visit user_path(@user)
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end

  it 'shows post show page when it\'s clicked' do
    visit user_path(@user)
    click_on 'Post 1'
    expect(page).to have_current_path(user_post_path(@user, @user.posts.first))
  end
end
