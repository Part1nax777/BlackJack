require_relative 'validator'
require_relative 'hand'
require_relative 'bank'

class Player
  include Validate
  attr_accessor :name, :score, :bank, :hand

  MSG_INCORRECT_NAME = 'You must input name'.freeze

  def initialize(name)
    @name = name
    @bank = Bank.new
    @bank.set_start_amount
    @score = 0
    validate!
    @hand = Hand.new
  end

  def can_start_game?
    @bank.money >= Bank::BET
  end

  def take_cards(deck, count = 1)
    @hand.cards += deck.take_card(count)
  end

  def fold_cards
    @hand.cards = []
  end

  def points
    @hand.points
  end

  def give_money(amount)
    @bank.put_money(amount)
  end

  def make_bet
    @bank.bet
  end

  private

  def validate!
    raise MSG_INCORRECT_NAME if name == '' || nil
  end
end
