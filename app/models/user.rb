class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :videos, through: :orders
  has_many :reviews
  has_many :purchases
  has_many :workouts
  has_many :goals, dependent: :destroy
  has_many :videos, dependent: :destroy
  
  validates :name, presence: true
  has_one_attached :photo
end
