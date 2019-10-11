class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_one_attached :image
end
