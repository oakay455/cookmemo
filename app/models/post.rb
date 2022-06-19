class Post < ApplicationRecord

  validates :body, presence: true, length: {maximum:250}

  belongs_to :member
  # has_many :favorites, dependent: :destroy

  has_one_attached :post_image

  # def favorited_by?(member)
    # favorites.exists?(member_id: member.id)
  # end


  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
