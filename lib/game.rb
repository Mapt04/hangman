class Game

    def initialize(dictionary, save_file=nil)
        @solution = dictionary.sample
        @guessed = []
        if save_file
           @save_file = save_file
           load
        end 
    end

    attr_reader :save_file

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
        
        puts status
        puts HANGMANIMAGES[wrong_guesses]
        puts "Wrong guesses: #{wrong_guesses}"
        puts "Letters guessed: #{@guessed.join(', ')}"
        puts "Letters not guessed: #{not_guessed.join(', ')}"
        puts
    end

    def status
        status_string = @solution.split("").join(" ")
        not_guessed.each do |letter|
            status_string.gsub!(letter, "_")
        end
        status_string
    end

    def pick_letter
        loop do
            print "Guess a letter ('save' to save game): "
            guess = gets.chomp.downcase
            if not_guessed.include? guess
                return guess
            end

            if guess == 'save'
                save
                next
            end
            
            puts "Invalid guess."
        end
    end

    def save
        Dir.mkdir('saves') unless Dir.exist?('saves')

        @save_file = "saves/#{SecureRandom.hex}.txt" unless @save_file

        File.open(@save_file, 'w') do |file|
            file.puts @solution
            file.print @guessed.join(",")
        end
        puts "Game state saved."
    end

    def load()
        save_info = File.read(@save_file).split("\n")
        @solution = save_info[0]
        @guessed = save_info[1].split(",")
    end

    def delete_save()
        File.delete(@save_file)
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