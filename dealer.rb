class Dealer < Player
  attr_accessor :name, :balance, :score

  def initialize
    @name = 'Dealer'
    @balance = 100
    @score = 0
  end
end
