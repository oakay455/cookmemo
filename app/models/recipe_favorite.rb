class RecipeFavorite < ApplicationRecord
  belongs_to :member
  belongs_to :recipe
end
