class Apartment < ApplicationRecord
    validates :number, numericality: true
    has_many :leases 
    has_many :tenants, through: :leases
end
