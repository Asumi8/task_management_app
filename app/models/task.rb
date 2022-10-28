class Task < ApplicationRecord
  validates :title, presence: true, length:{in:1..75}
  validates :content, presence: true, length:{in:1..300}
  validates :expired_at, presence: true
end
