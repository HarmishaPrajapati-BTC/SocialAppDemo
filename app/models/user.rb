class User < ApplicationRecord
  rolify
  has_friendship
  extend FriendlyId
  friendly_id :first_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  has_and_belongs_to_many :groups
  belongs_to :role, optional: true
  has_one_attached :profile_image
  has_many :likes, dependent: :destroy
  has_many :share_posts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  ransack_alias :search, :first_name_or_last_name_or_email_or_address

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
