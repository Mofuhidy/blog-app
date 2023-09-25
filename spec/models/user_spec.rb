require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter should be an integer' do
    subject.posts_counter = 'm'
    expect(subject).to_not be_valid
  end

  it 'Vaild post counter is bigger than 0' do
    subject.posts_counter = 7
    expect(subject).to be_valid
  end

  it 'Posts counter should be greated than or equal to zero' do
    subject.posts_counter = -1
    expect(subject).to be_invalid
  end

  describe 'Recent Posts' do
    before do
      4.times do
        Post.create(author_id: subject.id, title: 'Hello', text: 'This is my post')
      end
    end
    it 'should bring last 3 posts' do
      expect(subject.recent_posts).to eq subject.posts.order(created_at: :desc).limit(3)
    end
  end
end
