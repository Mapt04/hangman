# frozen_string_literal: true

# Game class
class Game
  def initialize(dictionary, save_file = nil)
    @solution = dictionary.sample
    @guessed = []
    return unless save_file

    @save_file = save_file
    load
  end

  attr_reader :save_file

  def play
    loop do
      display_status
      @guessed.push(pick_letter)
      return puts "You win! The word was: #{@solution}" if won?
      return puts "You lose! The word was: #{@solution}" if lost?
    end
  end

  def display_status
    puts status
    puts HANGMANIMAGES[wrong_guesses]
    puts "Wrong guesses: #{wrong_guesses}"
    puts "Letters guessed: #{@guessed.join(', ')}"
    puts "Letters not guessed: #{not_guessed.join(', ')}"
    puts
  end

  def status
    status_string = @solution.chars.join(' ')
    not_guessed.each do |letter|
      status_string.gsub!(letter, '_')
    end
    status_string
  end

  def pick_letter
    loop do
      print "Guess a letter ('save' to save game): "
      guess = gets.chomp.downcase
      return guess if not_guessed.include? guess

      if guess == 'save'
        save
        next
      end

      puts 'Invalid guess.'
    end
  end

  def save
    FileUtils.mkdir_p('saves')

    @save_file ||= "saves/#{SecureRandom.hex}.txt"

    File.open(@save_file, 'w') do |file|
      file.puts @solution
      file.print @guessed.join(',')
    end
    puts 'Game state saved.'
  end

  def load
    save_info = File.read(@save_file).split("\n")
    @solution = save_info[0]
    @guessed = save_info[1].split(',')
  end

  def delete_save
    File.delete(@save_file)
  end

  def not_guessed
    ('a'..'z').to_a - @guessed
  end

  def wrong_guesses
    @guessed.count { |letter| !@solution.include? letter }
  end

  def won?
    @solution.chars.all? { |letter| @guessed.include? letter }
  end

  def lost?
    wrong_guesses >= 7
  end
end
