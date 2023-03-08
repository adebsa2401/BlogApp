require 'rails_helper'

RSpec.describe 'User posts index page', type: :system do
  before do
    @user = User.create(
      name: 'Username',
      photo: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png',
      bio: 'Bio'
    )

    @post1 = @user.posts.create(title: 'Post 1', text: 'Body 1')
    @post2 = @user.posts.create(title: 'Post 2', text: 'Body 2')
    @post3 = @user.posts.create(title: 'Post 3', text: 'Body 3')

    @comment1 = @post1.comments.create(text: 'Comment 1', author: @user)
    @comment2 = @post2.comments.create(text: 'Comment 2', author: @user)

    @like1 = @post1.likes.create(author: @user)
    @like2 = @post2.likes.create(author: @user)
  end

  it 'shows the user name' do
    visit user_posts_path(@user)
    expect(page).to have_content('Username')
  end

  it 'shows the user photo' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png']")
  end

  it 'shows the number of posts the user has written' do
    visit user_posts_path(@user)
    expect(page).to have_content('Number of posts: 3')
  end

  it 'shows posts title' do
    visit user_posts_path(@user)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  it 'shows posts body' do
    visit user_posts_path(@user)
    expect(page).to have_content('Body 1')
    expect(page).to have_content('Body 2')
    expect(page).to have_content('Body 3')
  end

  it 'shows the number of comments each post has' do
    visit user_posts_path(@user)
    expect(page).to have_content('Comments: 1')
  end

  it 'shows the number of likes each post has' do
    visit user_posts_path(@user)
    expect(page).to have_content('Likes: 1')
  end

  it 'shows the comments on a post' do
    visit user_posts_path(@user)
    expect(page).to have_content('Comment 1')
  end

  it 'redirect to post sshow page when clicked on it' do
    visit user_posts_path(@user)
    click_on 'Post 1'
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end
end
