class Match < ApplicationRecord

  has_many :messages, dependent: :destroy
end

 
