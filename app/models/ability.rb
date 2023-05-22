class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
     if user.has_role?  (:admin)
       can :manage, Friend
     else
       can :read, Friend
     end
  end   
end
