class User < ApplicationRecord
  before_save :capitalize_name
  has_one_attached :photo
  has_many :books

  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  # belongs_to :sender, class_name: "User"
  # belongs_to :receiver, class_name: "User"

  belongs_to :sender, class_name: "User", optional: true
  belongs_to :receiver, class_name: "User", optional: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def capitalize_name
    self.full_name = full_name.split.map(&:capitalize).join(' ') if full_name.present?
  end
end
