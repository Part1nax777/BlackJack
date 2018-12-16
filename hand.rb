require_relative 'card'
require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def points
    sum = 0
    @cards.each do |card|
      sum += card.value
    end
    aces = ace_separator
    aces.each do |_ace|
      sum += 10 if sum + 10 <= 21
    end
    sum
  end

  def ace_separator
    ace_array = []
    @cards.each do |card|
      card.ace? ? ace_array << card : card
    end
    ace_array
  end
end
