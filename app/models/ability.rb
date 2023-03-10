class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is?(:admin)
      can :destroy, [Post, Comment]
    else
      can :destroy, [Post, Comment], author_id: user.id
    end
  end
end
