class Request < ApplicationRecord
  belongs_to :user
  has_many :exchanges

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :origin, presence: true
  validates :destination, presence: true

  REQUEST_TYPE = ["Folga", "Troca", "Extra"]
  validates :request_type, presence: true
  validates :request_type, inclusion: { in: REQUEST_TYPE }
end