require 'rails_helper'

RSpec.describe 'Post show method', type: :feature do
  before(:example) do
    @user = User.create(
      name: 'Moha',
      photo: 'https://example.com/photo.jpg',
      bio: 'Teacher from Yemen.',
      posts_counter: 8
    )

    @post = Post.create(
      title: 'Sample Post',
      text: 'This is a sample post text.',
      likes_counter: 5,
      comments_counter: 3,
      author: @user
    )

    @comment = Comment.new(user: @user, post: @post)
    @like = Like.new(user: @user, post: @post)

    visit user_post_path(user_id: @user.id, id: @post.id)
  end

  it 'displays the post title' do
    expect(page).to have_content(@post.title)
  end

  it 'displays the post author' do
    expect(page).to have_content("by #{@user.name}")
  end

  it 'displays the post comments count' do
    expect(page).to have_content("Comments : #{@post.comments_counter}")
  end

  it 'displays the post likes count' do
    expect(page).to have_content("Likes : #{@post.likes_counter}")
  end

  it 'displays the post text' do
    expect(page).to have_content(@post.text)
  end

  it 'displays comments' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'shows username of each commentor' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end
end
