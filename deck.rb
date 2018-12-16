require_relative 'card'

class Deсk
  SUITS = %w[+ <3 ^ <>].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_accessor :deck

  def initialize
    @deck = game_deck
  end

  def game_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
  end

  def take_card(num)
    deck.pop(num)
  end
end
