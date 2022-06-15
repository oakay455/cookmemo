class Bookmark < ApplicationRecord
  belongs_to :member
  belongs_to :recipe

  validates_uniqueness_of :recipe_id, scope: :member_id
  # バリデーション（ユーザーと記事の組み合わせは一意）
  # 同じ投稿を複数回お気に入り登録させないため。
end
