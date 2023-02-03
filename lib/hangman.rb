require_relative 'hangman_images.rb'
require_relative 'game.rb'
require 'securerandom'

dictionary = File.read('dictionary.txt')
dictionary_array = dictionary.split("\n")

def choose_load_option
    loop do
        puts "(1) New game"
        puts "(2) Load game"
        print "Enter: "
        selection = gets.to_i
        return selection if selection in 1..2
        puts "Invalid choice.\n"
    end
end

def show_save_files(saves)
    saves.each_with_index do |save_file, index|
        status = Game.new([], save_file).status
        puts ("(#{index+1})  #{status}")
    end
end

def choose_save_file(saves)
    loop do
        puts
        show_save_files(saves)
        print "Select a file: "
        selection = gets.to_i
        return saves[selection-1] if (1..saves.length).include?(selection)
        puts "Invalid choice.\n"
    end
end

puts "===== Welcome to Hangman! =====\n\n"

load_option = choose_load_option

if load_option == 2
    saves = Dir["saves/*.txt"]
    save_file = choose_save_file(saves)
end

puts

game = Game.new(dictionary_array, save_file)
game.play