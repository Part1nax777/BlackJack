require_relative 'hand'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'
require_relative 'bank'

class Game
  include Interface

  def initialize
    invite_game
    @player = user_name
    @dealer = Dealer.new
    @bank = Bank.new
  end

  def start_game
    can_start_game
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
    @player.bank.money < 10 || @dealer.bank.money < 10
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
    print_info(@player_hand, @player.bank.money)
    calculate_score_dealer
  end

  def make_bet
    @bank = 0
    @bank += @player.bank.bet
    @bank += @dealer.bank.bet
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
    @player.fold_cards
    @player_cards = @player.take_cards(@deck, 2)
  end

  def get_cards_dealer
    @dealer.fold_cards
    @dealer_cards = @dealer.take_cards(@deck, 2)
  end

  def calculate_score_player
    @player_hand = @player.points
  end

  def calculate_score_dealer
    @dealer_hand = @dealer.points
  end

  def user_name
    puts 'Enter you name: '
    name = gets.chomp
    Player.new(name)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry 
  end

  def dealer_movie
    @dealer_hand < 18
    @dealer_cards = @dealer.take_cards(@deck)
    @dealer_hand = @dealer.points
  end

  def player_movie
    @player_cards = @player.take_cards(@deck)
    @player_hand = @player.points
    print_player_cards(@player_cards)
    print_info(@player_hand, @player.bank.money)
  end

  def game_results
    winner_selection
    print_all_cards(@player_cards, @dealer_cards)
    print_all_info(@player_hand, @player.bank.money, @dealer_hand, @dealer.bank.money)
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
    winner.bank.money += @bank
    @bank = 0
  end

  def draw
    @player.bank.money += @bank / 2
    @dealer.bank.money += @bank / 2
  end
end
