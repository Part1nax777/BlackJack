class Bank
  START_AMOUNT = 100
  BET = 10

  attr_accessor :money

  def initialize
    @money = 0
  end

  def set_start_amount
    @money += START_AMOUNT
  end

  def bet
    @money -= BET
    10
  end

  def put_money(amount)
    @money += amount
  end
end
