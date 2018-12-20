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
    print_bank(@bank.money)
  end

  def process_turn
    show_menu
    value = gets.to_i
    case value
    when 1 then menu_add_card
    when 2 then menu_skip_move
    when 3 then menu_open_cards
    end
  end

  private

  def can_start_game?
    @player.bank.money >= Bank::BET && @dealer.bank.money >= Bank::BET
  end

  def can_start_game
    unless can_start_game?
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
    print_info(@player.points, @player.bank.money)
    calculate_score_dealer
  end

  def make_bet
    @bank.money += @player.make_bet
    @bank.money += @dealer.make_bet
  end

  def menu_add_card
    player_movie
    dealer_movie
    game_results
    new_game
  end

  def menu_skip_move
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
    @player.points
  end

  def calculate_score_dealer
    @dealer.points
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
    return unless @dealer.will_take_card?
    @dealer_cards = @dealer.take_cards(@deck)
    @dealer.points
  end

  def player_movie
    @player_cards = @player.take_cards(@deck)
    @player.points
    print_player_cards(@player_cards)
    print_info(@player.points, @player.bank.money)
  end

  def game_results
    winner_selection
    print_all_cards(@player_cards, @dealer_cards)
    print_all_info(@player.points, @player.bank.money, @dealer.points, @dealer.bank.money)
    print_winner_selection
  end

  def winner_selection
    if @player.points > Hand::MAX_POINTS
      win(@dealer)
    elsif dealer_win?
      win(@dealer)
    elsif @player.points == Hand::MAX_POINTS || player_win?
      win(@player)
    elsif (@player.points == @dealer.points) && @player.points <= Hand::MAX_POINTS
      draw
    else
      win(@dealer)
    end
  end

  def dealer_win?
    @player.points > Hand::MAX_POINTS && @dealer.points > Hand::MAX_POINTS
  end

  def player_win?
    (@player.points <= Hand::MAX_POINTS && @dealer.points > Hand::MAX_POINTS) || (@player.points > @dealer.points)
  end

  def win(winner)
    winner.give_money(@bank.money)
    @bank.money = 0
  end

  def draw
    @draw_bank = @bank.money / 2
    @player.give_money(@draw_bank)
    @dealer.give_money(@draw_bank)
  end
end
