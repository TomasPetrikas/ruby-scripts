# frozen_string_literal: true

require_relative 'caesar_cipher'

# This is just a little extra thing I wanted to do
#
# To use, type the following command:
#
# ruby vigenere_cipher.rb [message] [keyword]
#
# Examples:
#
# ruby vigenere_cipher.rb "Attack at dawn" lemon
#   (prints "Lxfopv ef rnhr")
# ruby vigenere_cipher.rb thequickbrownfoxjumpsoverthelazydog LION
#   (prints "epsdfqqxmzcjynckucacdwjrcbvrwinlowu")
#
#
# (There is a slight bug here in that it prints the result of caesar_cipher.rb
# as well, but whatever)
module Vigenere
  def self.vigenere_cipher(msg, keyword)
    return msg if keyword.empty?

    # Remove non-letter characters and upcase
    keyword = keyword.gsub(/[^A-Za-z]/, '').upcase
    keyword_index = 0

    msg_array = msg.split('')

    new_msg = msg_array.map do |char|
      shift = keyword[keyword_index].ord - 'A'.ord

      # Only change keyword_index if char is alphabetic
      if char.match?(/[A-Za-z]/)
        if !keyword[keyword_index + 1].nil?
          keyword_index += 1
        else
          keyword_index = 0
        end
      end

      Caesar.caesar_cipher(char, shift)
    end

    new_msg.join
  end
end

puts Vigenere.vigenere_cipher(ARGV[0], ARGV[1]) unless ARGV[0].nil? || ARGV[1].nil?
