class User < ApplicationRecord
  has_one_attached :photo
  has_many :books
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
