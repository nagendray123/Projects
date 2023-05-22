class User < ApplicationRecord
  has_many :friends
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   

      after_create :assign_default_role


      # validate :must_have_a_role, on: :update

      # private
      # def must_have_a_role
      #     unless roles.any?
      #         errors.add(:roles, "Must have a 1 role")
      #       end
      #   end
            
        

  def assign_default_role
      self.add_role(:newuser) if self.roles.blank?
   end
end
