require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  subject do
    Post.new(author: user,
             title: 'Hi',
             text: 'This is my post')
  end
  before { subject.save }

  it 'Title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title should not exceede 250 characters' do
    subject.title = 'm' * 260
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be an integer' do
    subject.likes_counter = 'm'
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be greated than or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to be_invalid
  end

  it 'comments counter should be an integer' do
    subject.comments_counter = 'm'
    expect(subject).to_not be_valid
  end

  it 'comments counter should be greated than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to be_invalid
  end

  describe 'Update user posts counter' do
    it 'should record the posts counter' do
      subject.update_posts_counter
      assert_equal 1, user.posts_counter
    end
  end

  describe 'Recent comments' do
    before do
      6.times do
        Comment.create(user_id: user.id, post_id: subject.id, text: 'Hi Author!')
      end
    end
    it 'it should return 5 recent comments' do
      expect(subject.recent_comments).to eq subject.comments.order(created_at: :desc).limit(5)
    end
  end
end
