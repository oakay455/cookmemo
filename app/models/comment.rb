class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :recipe

  validates :comment, presence: true
end
