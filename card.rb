class Card
  attr_reader :rank, :suit

  ACE_CORRECTION = 10
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    if face_card?
      10
    elsif ace?
      1
    else
      @rank.to_i
    end
  end

  def face_card?
    'JQK'.include?(rank.to_s)
  end

  def ace?
    @rank == 'A'
  end
end
