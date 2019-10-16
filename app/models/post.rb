class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_one :share_post, dependent: :destroy
end
