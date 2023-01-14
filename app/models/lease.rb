class Lease < ApplicationRecord
  validates :rent, numericality: true
  belongs_to :apartment
  belongs_to :tenant
  
  # , optional: true
end
