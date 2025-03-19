class Book < ApplicationRecord
  has_many_attached :photos
  acts_as_taggable_on :tags
  acts_as_taggable_on :genres
  has_many :likes
  belongs_to :user
  GENRES = ['fantasia', 'terror']
  enum condition: { novo: 0, usado: 1 }
end
