class Recipe < ApplicationRecord

  validates :title, presence: true
  validates :ingredient, presence: true
  validates :body, presence: true, length: {maximum:250}

  belongs_to :member
  has_many :comments, dependent: :destroy
  has_many :recipe_favorites, dependent: :destroy
  belongs_to :category
  has_many :bookmarks, dependent: :destroy
  has_many :tags, dependent: :destroy

  has_one_attached :recipe_image

  def recipe_favorited_by?(member)
    recipe_favorites.exists?(member_id: member.id)
  end

  def get_recipe_image(width, height)
    unless recipe_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      recipe_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    recipe_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.recipe_search(recipe_search)
    if recipe_search != ""
      Recipe.where(['title LIKE(?) OR ingredient LIKE(?) OR body LIKE(?)', "%#{recipe_search}%", "%#{recipe_search}%", "%#{recipe_search}%"])
    else
      Recipe.all
    end
  end


end
