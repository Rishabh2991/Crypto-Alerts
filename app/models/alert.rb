class Alert < ApplicationRecord
  belongs_to :user
  validates :target_price,presence: true
  
end