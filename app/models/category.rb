class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy
  # has_many :posts, dependent: :destroy
end
