class Friend < ApplicationRecord
   paginates_per 5

	belongs_to :user
    has_one_attached :profile_image


    # validates :first_name, presence: true
    # validates :last_name, presence: true
    # validates :email, presence: true
    # validates :phone, presence: true
    # validates :address, presence: true


    resourcify

       has_many :users, through: :roles, class_name: 'User', source: :users

       
       # has_many :creator, -> { where(:roles => {name: :creator}) }, through: :roles, class_name: 'User', source: :users
       # has_many :editor, -> { where(:roles => {name: :editor}) }, through: :roles, class_name: 'User', source: :users

    validates :first_name,
              :last_name,
              :email, 
              :phone,
              :address,
              presence: true

   def self.ransackable_attributes(auth_object = nil)
      ["first_name"]
   end
end
