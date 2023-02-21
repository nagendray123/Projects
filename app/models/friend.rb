class Friend < ApplicationRecord
	belongs_to :user

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :address, presence: true

end
