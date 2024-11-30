class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { subscriber: 0, creator: 1 }

  # Validations
  validates :role, presence: true

  has_many :courses, foreign_key: :user_id, dependent: :destroy
  has_many :subscriptions
  has_many :subscribed_courses, through: :subscriptions, source: :course
end
