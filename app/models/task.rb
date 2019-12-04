class Task < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :priority, presence: true
  validates :status, presence: true

  enum priority:{
    高: 0, 
    中: 1, 
    低: 2, 
  }

  def self.search(title_params) #self.でクラスメソッドとしている
    Task.where(['title LIKE ?', "%#{title_params}%"])
  end
end
