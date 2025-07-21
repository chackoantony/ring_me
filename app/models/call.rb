class Call < ApplicationRecord
  validates :to_number, presence: true, format: { with: /\A\+?[1-9]\d{1,14}\z/ }
  validates :status, presence: true
  validates :sid, uniqueness: true, allow_blank: true
  validates :body, length: { maximum: 2000 }

  enum status: [:pending, :processing, :completed, :error]
end
