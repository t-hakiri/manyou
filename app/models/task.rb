class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
end
