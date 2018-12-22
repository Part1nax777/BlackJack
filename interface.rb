class Interface

  INVITE_GAME = 'Welcome to Black Jack'

  def invite_game
    puts INVITE_GAME
  end

  def show_menu
    puts <<~MENU
    MENU:
    1. Add card.
    2. Scip move.
    3. Open cards.
    MENU
    gets.to_i
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

  def ask_new_round?
    puts 'New round? (y/n)'
    true if gets.chomp == 'y'
  end

  def ask_name
    puts 'Enter you name: '
    gets.chomp
  end

  def error_message(e)
    puts "Error: #{e.message}"
  end      

  def print_dealer_two_cards
    puts '*'
    puts '*'
  end

  def print_info(player)
    puts "Hand score: #{player.points}, Balance: #{player.bank.money}"
  end

  def print_bank(bank)
    puts "Bank: #{bank}"
  end

  def print_winner(winner)
    puts "#{winner.name} win!"
  end

  def print_draw
    puts 'Draw'
  end


  def game_over
    puts 'Game over, you not have money'
  end

  def print_all_info(player, dealer)
    puts "Player info: score: #{player.points}, bank: #{player.bank.money}"
    puts "Dealer info: score: #{dealer.points}, bank: #{dealer.bank.money}"
  end

  def print_all_cards(player_card, dealer_card)
    puts 'Player cards: '
    print_player_cards(player_card)
    puts 'Dealer cards: '
    print_player_cards(dealer_card)
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
