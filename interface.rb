module Interface

  def invite_game
    puts 'Welcome to Black Jack'
  end 

  def new_game
    puts 'New round? (y/n)'
    if gets.chomp == 'y'
      start_game
    else
      exit
    end
  end

  def show_menu
    puts <<~MENU
    MENU:
    1. Add card.
    2. Scip move.
    3. Open cards.
    MENU
  end 

  def print_header(name)
    puts "#{name.capitalize} cards: "
  end

  def print_player_cards(cards)
    cards_array = cards_to_array(cards)
    cards_array.each do |card|
    puts "#{card.rank} #{card.suit}"
    end
  end

  def print_dealer_two_cards
    puts '*'
    puts '*'
  end

  def print_info(score, balance)
    puts "Hand score: #{score}, Balance: #{balance}"
  end

  def print_bank(bank)
    puts "Bank: #{bank}"
  end

  def print_player_win(name)
    puts "Player #{name.name} win"
  end

  def print_dealer_win
    puts 'Dealer win'
  end

  def print_draw
    puts 'Draw'
  end

  def print_winner_selection
    if player_win? && @player_hand <= 21
      print_player_win(@player)
    elsif @player_hand == @dealer_hand
      print_draw
    else
      print_dealer_win
    end 
  end

  def game_over
    puts 'Game over, you not have money'
  end

  def print_all_info(player_score, player_bank, dealer_score, dealer_bank)
    puts "Player info: score: #{player_score}, bank: #{player_bank}"
    puts "Dealer info: score: #{dealer_score}, bank: #{dealer_bank}"
  end

  def print_all_cards(player_cards, dealer_cards)
    puts 'Player cards: '
    print_player_cards(player_cards)
    puts 'Dealer cards: '
    print_player_cards(dealer_cards)
  end

  private

  def cards_to_array(cards)
    cards_array ||= []
    cards.each do |card|
      cards_array << card
    end
    cards_array
  end
end
