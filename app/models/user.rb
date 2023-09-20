# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foriegn_key: 'author_id'
  has_many :comments, foriegn_key: 'author_id'
  has_many :likes, foriegn_key: 'author_id'
end
