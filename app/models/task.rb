class Task < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  
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

  # def self.search(search_params) #self.でクラスメソッドとしている
  #   Task.where(['title LIKE ?', "%#{search_params}%"])
  # end

  scope :sorted, -> { order(created_at: :desc) }
  #scope :recent, -> { active.sorted }
  scope :deadline_sort, -> { order(deadline: :desc) }
  scope :title_search, -> (search_params){ Task.where(['title LIKE ?', "%#{search_params}%"]) }
  scope :status_search, -> (search_params){ Task.where(['status LIKE ?', "%#{search_params}%"]) }
  scope :sort_priority, -> { order(priority: :asc) } 

# @tasks = @tasks.where(['status LIKE ?', params[:task][:status_search]]

# def index
#     @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(5)
#     if params[:sort_expired] == "true"
#       @tasks = Task.all.order(deadline: "desc").page(params[:page]).per(5)
#     elsif params[:task].present?
#       @tasks = Task.search(params[:task][:title_search]).page(params[:page]).per(5)
#       if params[:task][:status_search].present?
#         @tasks = @tasks.where(['status LIKE ?', params[:task][:status_search]])
#       end
#     elsif params[:sort_priority] == "true"
#       @tasks = Task.all.order(priority: "asc").page(params[:page]).per(5)
#     end




  
end


