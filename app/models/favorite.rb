class Favorite < ApplicationRecord
  belongs_to :photographer
  belongs_to :post
end
