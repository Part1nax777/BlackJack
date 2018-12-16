require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'

class Game
  attr_accessor :bank
  include Interface

  def initialize
    invite_game
    @player = user_name
    @dealer = Dealer.new
  end

  def start_game
    can_start_game
    reset_round!
    @deck = Deсk.new
    make_bet
    start_player_cards
    start_dealer_cards
    start_calculate_score
    print_bank(@bank)
  end

  def process_turn
    show_menu
    value = gets.to_i
    case value
    when 1 then menu_add_card
    when 2 then menu_scip_move
    when 3 then menu_open_cards
    end
  end

  def can_start_game?
    @player.balance < 10 || @dealer.balance < 10
  end

  def can_start_game
    if can_start_game?
      game_over
      exit
    end
  end

  def start_player_cards
    get_cards_player
    print_header(@player.name)
    print_player_cards(@player_cards)
  end

  def start_dealer_cards
    get_cards_dealer
    print_header(@dealer.name)
    print_dealer_two_cards
  end

  def start_calculate_score
    calculate_score_player
    print_info(@player_hand, @player.balance)
    calculate_score_dealer
  end

  def make_bet
    @bank = 0
    @bank += @player.bet
    @bank += @dealer.bet
  end

  def menu_add_card
    player_movie
    dealer_movie
    game_results
    new_game
  end

  def menu_scip_move
    dealer_movie
    game_results
    new_game
  end

  def menu_open_cards
    game_results
    new_game
  end

  def get_cards_player
    @player_cards = @deck.take_card(2)
  end

  def get_cards_dealer
    @dealer_cards = @deck.take_card(2)
  end

  def calculate_score_player
    @player_hand = Hand.new(@player_cards).points
  end

  def calculate_score_dealer
    @dealer_hand = Hand.new(@dealer_cards).points
  end

  def user_name
    puts 'Enter you name'
    name = gets.chomp
    if name == '' || nil
      user_name
    else
      Player.new(name)
    end
  end

  def dealer_movie
    @dealer_hand < 18
    @dealer_cards += @deck.take_card(1)
    @dealer_hand = Hand.new(@dealer_cards).points
  end

  def player_movie
    @player_cards += @deck.take_card(1)
    @player_hand = Hand.new(@player_cards).points
    print_player_cards(@player_cards)
    print_info(@player_hand, @player.balance)
  end

  def game_results
    winner_selection
    print_all_cards(@player_cards, @dealer_cards)
    print_all_info(@player_hand, @player.balance, @dealer_hand, @dealer.balance)
    print_winner_selection
  end

  def winner_selection
    if @player_hand > 21
      win(@dealer)
    elsif dealer_win?
      win(@dealer)
    elsif @player_hand == 21 || player_win?
      win(@player)
    elsif (@player_hand == @dealer_hand) && @player_hand <= 21
      draw
    else
      win(@dealer)
    end
  end

  def dealer_win?
    @player_hand > 21 && @dealer_hand > 21
  end

  def player_win?
    (@player_hand < 21 && @dealer_hand > 21) || (@player_hand > @dealer_hand)
  end

  def win(winner)
    winner.balance += @bank
    @bank = 0
  end

  def draw
    @player.balance += @bank / 2
    @dealer.balance += @bank / 2
  end

  def reset_round!
    @player_hand = 0
    @dealer_hand = 0
    @player_cards = []
    @dealer_cards = []
  end
end
