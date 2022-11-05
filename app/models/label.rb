class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, though: :labelings, source: :task
end
