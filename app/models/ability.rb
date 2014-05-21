class Ability
  include CanCan::Ability

  def initialize( current_user )
    if not current_user
      can :read, Tournament
    else
      can [ :read, :update ], User do |user|
        user == current_user
      end

      can [ :read, :create ], Tournament
      can [ :update, :destroy, :management ], Tournament do |tournament|
        current_user.tournaments.include?( tournament )
      end

      can :create, Subscription
      can :update, Subscription do |subscription|
        current_user.tournaments.include?( army.subscription.tournament )
      end

      can :update, Army do |army|
        current_user.subscriptions.include?( army.subscription ) or
        current_user.tournaments.include?( army.subscription.tournament )
      end
    end
  end
end
