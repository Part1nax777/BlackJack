class Card
  attr_reader :rank, :suit

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
