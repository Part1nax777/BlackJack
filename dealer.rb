require_relative 'player'

class Dealer < Player
  def initialize
    super('Dealer')
  end

  def will_take_card?
    @hand.points < 17
  end
end
