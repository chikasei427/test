class Photographer < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :posts
  has_many :favorites
  has_many :favoritings, through: :favorites, source: :post
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'post_id'
  has_many :favoritters, through: :reverses_of_favorite, source: :photographer
  
  def favorite(post)
      self.favorites.find_or_create_by(post_id: post.id)
  end

  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  
  def favoriting?(post)
    self.favoritings.include?(post)
  end
  
  def favorited
    favorites = Favorite.all
    @count_favorited = []
    favorites.each do |favorite|
      if favorite.post.photographer.id == self.id
        @count_favorited.push(favorite.post)
      end
    end
    return @count_favorited.size
  end


end
