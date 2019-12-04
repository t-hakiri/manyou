class Task < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }

  def self.search(title_params) #self.でクラスメソッドとしている
    Task.where(['title LIKE ?', "%#{title_params}%"])
  end
end
