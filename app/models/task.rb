class Task < ApplicationRecord
  validates :title, presence: true, length:{in:1..75}
  validates :content, presence: true, length:{in:1..300}
  validates :expired_at, presence: true
  validates :status, presence: true
  enum status: {未着手:0, 着手:1, 完了:2}
    # t('enum.task.status.not_start'):0, 
    # t('enum.task.status.start'):1,
    # t('enum.task.status.complete'):2
end
