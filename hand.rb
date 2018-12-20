require_relative 'card'
require_relative 'deck'

class Hand
  attr_accessor :cards

  MAX_POINTS = 21

  def initialize(cards = [])
    @cards = cards
  end

  def points
    sum = 0
    sum = @cards.map(&:value).sum
    aces = @cards.select(&:ace?)
    aces.size.times do
      corrected_sum = sum + Card::ACE_CORRECTION
      sum = corrected_sum if corrected_sum <= MAX_POINTS
    end
    sum
  end
end
