# frozen_string_literal: true

# Menu class
class Menu
  def welcome
    puts "===== Welcome to Hangman! =====\n\n"
  end

  def goodbye
    puts "===== See you later! =====\n\n"
  end

  def choose_load_option
    loop do
      puts '(1) New game'
      puts '(2) Load game'
      print 'Enter: '
      selection = gets.to_i
      return selection if selection in 1..2

      puts "Invalid choice.\n"
    end
  end

  def show_save_files(saves)
    saves.each_with_index do |save_file, index|
      game = Game.new([], save_file)
      status = game.status
      puts("(#{index + 1})  #{status}")
      game.delete
    end
  end

  def choose_save_file(saves)
    loop do
      puts
      show_save_files(saves)
      print 'Select a file: '
      selection = gets.to_i
      return saves[selection - 1] if (1..saves.length).include?(selection)

      puts "Invalid choice.\n"
    end
  end

  def request_save_delete(game)
    loop do
      print 'Since the game is over, do you wish to delete the save? (y/n): '
      response = gets.chomp.downcase

      return game.delete_save if response == 'y'
      return nil if response == 'n'

      puts 'Invalid choice.'
    end
  end

  def play_agin?
    loop do
      print 'Do you wish to play again? (y/n): '
      response = gets.chomp.downcase

      return true if response == 'y'
      return false if response == 'n'

      puts 'Invalid choice.'
    end
  end
end
