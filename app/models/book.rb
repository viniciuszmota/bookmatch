class Book < ApplicationRecord
  acts_as_taggable_on :tags
  acts_as_taggable_on :genres
  belongs_to :user
  GENRES = ['fantasia', 'terror']
  enum condition: { novo: 0, usado: 1 }
end
