class Book < ApplicationRecord
  has_many_attached :photos
  acts_as_taggable_on :tags
  acts_as_taggable_on :genres
  has_many :likes
  belongs_to :user
  GENRES = ['Fantasia', 'Terror', 'Ficção Científica', 'Romance', 'Mistério', 'Aventura', 'Drama', 'Distopia', 'Suspense', 'Biografia']
  enum condition: { novo: 0, usado: 1, danificado: 2, colecionador: 3 }

 validates :title, :author, :publisher, :condition, presence: true
 validates :photos, presence: true
end
