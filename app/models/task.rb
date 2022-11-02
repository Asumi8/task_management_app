class Task < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  validates :title, presence: true, length:{in:1..75}
  validates :content, presence: true, length:{in:1..300}
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: {未着手:0, 着手:1, 完了:2}
  enum priority: {高:0, 中:1, 低:2}

  paginates_per 4 #ページネーション

  scope :title_and_status_search, -> (title, status){where("title LIKE ?", "%#{title}%").where(status: status)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status){ where(status: status)}
  scope :expired_list, -> { order(expired_at: :DESC) }
  scope :priority_list, -> { order(priority: :ASC ) }
  scope :created_list, -> { order(created_at: :DESC) }
end
