class Match < ApplicationRecord
  belongs_to :first_like, class_name: 'Like'
  belongs_to :second_like, class_name: 'Like'
end
