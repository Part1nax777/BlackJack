require_relative 'card'

class Deсk
  attr_accessor :deck

  def initialize
    @deck = game_deck
  end

  def game_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
  end

  def take_card(num)
    deck.pop(num)
  end
end
