class Post < ApplicationRecord
  belongs_to :user
  has_many :group
  has_many :likes, dependent: :destroy
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :share_posts, dependent: :destroy
end
