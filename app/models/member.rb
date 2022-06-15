class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :bookmarks, dependent: :destroy
  # has_many :bookmarked_recipes, through: :bookmarks, source: :recipe

  has_one_attached :profile_image

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Member.where(name: content)
    elsif method == 'forward'
      Member.where('name LIKE?', content+'%')
    elsif method == 'backward'
      Member.where('name LIKE?', '%'+content)
    else
      Member.where('name LIKE?', '%'+content+'%')
    end
  end

  #フォローする
  def follow(member)
    relationships.create(followed_id: member.id)
  end

  #フォロー外す
  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  # is_deletedがfalseならtrueを返すようにしている、
  #退会したら再度ログインできないようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end


  #お気に入り（ブックマーク）テーブルにrecipe_idが存在しているか確認
  def bookmarked_by?(recipe_id)
    bookmarks.where(recipe_id: recipe_id).exists?
  end

  #いいねテーブルにrecipe_idが存在しているか確認
  def favorited_by?(recipe_id)
    recipe_favorites.where(recipe_id: recipe_id).exists?
  end
end
