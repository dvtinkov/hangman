# encoding: utf-8
#
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative "lib/console_interface"
require_relative "lib/game"

def get_word
  File.readlines("#{__dir__}/data/words.txt", chomp: true, encoding: "utf-8").sample
end

word = get_word

game = Game.new(word)
console_interface = ConsoleInterface.new(game)

until game.over?
  console_interface.print_out
  letter = console_interface.get_input
  game.play!(letter)
end

console_interface.print_out
