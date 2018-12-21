require_relative 'hand'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'
require_relative 'bank'

class Game
  def initialize
    puts Interface::INVITE_GAME
    @player = user_name
    @dealer = Dealer.new
    @bank = Bank.new
    @interface = Interface.new
  end

  def start_game
    can_start_game
    @deck = Deсk.new
    make_bet
    start_player_cards
    start_dealer_cards
    show_start_score
    @interface.print_bank(@bank.money)
  end

  def process_turn
    @interface.show_menu
    value = gets.to_i
    case value
    when 1 then menu_add_card
    when 2 then menu_skip_move
    when 3 then menu_open_cards
    end
  end

  private

  def can_start_game?
    @player.can_start_game? && @dealer.can_start_game?
  end

  def can_start_game
    unless can_start_game?
      @interface.game_over
      exit
    end
  end

  def start_player_cards
    get_cards_player
    @interface.print_header(@player.name)
    @interface.print_player_cards(@player_cards)
  end

  def start_dealer_cards
    get_cards_dealer
    @interface.print_header(@dealer.name)
    @interface.print_dealer_two_cards
  end

  def show_start_score
    @interface.print_info(@player)
  end

  def make_bet
    @bank.put_money(@player.make_bet)
    @bank.put_money(@dealer.make_bet)
  end

  def new_game
    puts 'New round? (y/n)'
    if gets.chomp == 'y'
      start_game
    else
      exit
    end
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

    @dealer.take_cards(@deck)
  end

  def player_movie
    @player.take_cards(@deck)
  end

  def game_results
    @interface.print_all_cards(@player.hand.cards, @dealer.hand.cards)
    winner = winner_selection
    if winner
      win(winner)
      @interface.print_winner(winner)
      @interface.print_all_info(@player, @dealer)
    else
      draw
      @interface.print_draw
      @interface.print_all_info(@player, @dealer)
    end
  end

  def winner_selection
    return if (@player.points > Hand::MAX_POINTS && @dealer.points > Hand::MAX_POINTS) || @player.points == @dealer.points
    if @player.points > Hand::MAX_POINTS
      @dealer
    elsif @dealer.points > Hand::MAX_POINTS
      @player
    else
      [@player, @dealer].max_by(&:points)
    end
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
