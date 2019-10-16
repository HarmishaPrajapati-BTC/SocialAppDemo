class SharePost < ApplicationRecord
  has_many :user
  belongs_to :post
end
