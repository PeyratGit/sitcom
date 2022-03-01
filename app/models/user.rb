class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :follower_follows, source: :following

  has_many :following_follows, class_name: "Follow", foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :following_follows, source: :follower

  has_many :feedbacks, dependent: :destroy
  has_many :wishes, dependent: :destroy
end
