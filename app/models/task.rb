class Task < ApplicationRecord
  validates :title, presence: true, length:{in:1..75}
  validates :content, presence: true, length:{in:1..300}
  validates :expired_at, presence: true
  validates :status, presence: true
  enum status: {未着手:0, 着手:1, 完了:2}
    # t('enum.task.status.not_start'):0, 
    # t('enum.task.status.start'):1,
    # t('enum.task.status.complete'):2
  scope :title_and_status_search, -> (title, status){where("title LIKE ?", "%#{title}%").where(status: status)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status){ where(status: status)}
  scope :expired_list, -> { order(expired_at: :DESC) }
  scope :created_list, -> { order(created_at: :DESC) }
end
