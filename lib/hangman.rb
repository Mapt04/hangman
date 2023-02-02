require_relative 'hangman_images.rb'

dictionary = File.read('dictionary.txt')
dictionary_array = dictionary.split("\n")

class Game

    def initialize(dictionary)
        @solution = dictionary.sample
        @guessed = []
    end

    def play
        loop do
            display_status
            @guessed.push(pick_letter)
            if won?
                puts "You win! The word was: #{@solution}"
                return nil
            end
            if lost?
                puts "You lose! The word was: #{@solution}"
                return nil
            end
        end
    end

    def display_status
        status = @solution.split("").join(" ")
        not_guessed.each do |letter|
            status.gsub!(letter, "_")
        end
        puts status

        puts HANGMANIMAGES[wrong_guesses]
        puts "Wrong guesses: #{wrong_guesses}"
        puts "Letters guessed: #{@guessed.join(', ')}"
        puts "Letters not guessed: #{not_guessed.join(', ')}"
        puts
    end

    def pick_letter
        loop do
            print "Guess a letter: "
            guess = gets.chomp.downcase
            if not_guessed.include? guess
                return guess
            end
            puts "Invalid guess."
        end
    end

    def not_guessed
        ('a'..'z').to_a - @guessed
    end

    def wrong_guesses
        @guessed.count {|letter| !@solution.include? letter}
    end

    def won?
        @solution.split("").all? {|letter| @guessed.include? letter}
    end

    def lost?
        wrong_guesses >= 7
    end
end

puts "===== Welcome to Hangman! =====\n\n"

game = Game.new(dictionary_array)

game.play