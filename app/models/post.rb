class Post < ApplicationRecord
  belongs_to :photographer
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :picture, presence: true
  mount_uploader :picture, ImageUploader
end
