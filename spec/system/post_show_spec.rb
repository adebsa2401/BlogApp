require 'rails_helper'

RSpec.describe 'Post show page', type: :system do
  before do
    @user = User.create(
      name: 'Username',
      photo: 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__480.png',
      bio: 'Bio'
    )
    @post = @user.posts.create(title: 'Post 1', text: 'Body 1')
    @comment1 = @post.comments.create(text: 'Comment 1', author: @user)
    @comment2 = @post.comments.create(text: 'Comment 2', author: @user)
    @like = @post.likes.create(author: @user)
  end

  it 'shows the post title' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Post 1')
  end

  it 'shows the post author' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Username')
  end

  it 'shows how many comments does the post have' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Comments: 2')
  end

  it 'shows how many likes does the post have' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Likes: 1')
  end

  it 'shows the post body' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Body 1')
  end

  it 'shows the post comments author' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Username')
  end

  it 'shows the post comments body' do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Comment 1')
    expect(page).to have_content('Comment 2')
  end
end
