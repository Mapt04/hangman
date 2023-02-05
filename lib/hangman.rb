# frozen_string_literal: true

require_relative 'hangman_images'
require_relative 'game'
require_relative 'menu'
require 'securerandom'

dictionary = File.read('dictionary.txt')
dictionary_array = dictionary.split("\n")

menu = Menu.new

menu.welcome

load_option = menu.choose_load_option

if load_option == 2
  saves = Dir['saves/*.txt']
  save_file = menu.choose_save_file(saves)
end

game = Game.new(dictionary_array, save_file)
game.play

menu.request_save_delete(game) if game.save_file
