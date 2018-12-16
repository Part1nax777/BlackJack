class Player
  attr_accessor :name, :balance, :score
  def initialize(name)
    @name = name
    @balance = 100
    @score = 0
  end

  def bet
    @balance -= 10
    10
  end

  def calculate_score; end
end
