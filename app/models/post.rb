class Post < ApplicationRecord
  belongs_to :photographer
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :picture, presence: true
  
  has_many :favorites,dependent: :destroy
  has_many :favoritings, through: :favorites, source: :post
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'post_id'
  has_many :favoritters, through: :reverses_of_favorite, source: :photographer
  
  
  mount_uploader :picture, ImageUploader
end
