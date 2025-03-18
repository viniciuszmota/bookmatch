class Match < ApplicationRecord
  belongs_to :first_like, class_name: "Like", foreign_key: "first_like_id"
  belongs_to :second_like, class_name: "Like", foreign_key: "second_like_id"

  has_many :messages, dependent: :destroy
end
