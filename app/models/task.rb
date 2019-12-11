class Task < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :title,  presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :priority, presence: true
  validates :deadline, presence: true
  validates :status, presence: true

  enum priority:{
    高: 0, 
    中: 1, 
    低: 2, 
  }

  # def self.search(search_params)
  #   Task.where(['title LIKE ?', "%#{search_params}%"])
  # end

  scope :sorted, -> { order(created_at: :desc) }
  #scope :recent, -> { active.sorted }
  scope :deadline_sort, -> { order(deadline: :desc) }
  scope :title_search, -> (search_params){ Task.where(['title LIKE ?', "%#{search_params}%"]) }
  scope :status_search, -> (search_params){ Task.where(['status LIKE ?', "%#{search_params}%"]) }
  scope :sort_priority, -> { order(priority: :asc) } 
  
end


