# frozen_string_literal: true

# To use, type the following command:
#
# ruby caesar_cipher.rb [message] [shift]
#
# Examples:
#
# ruby caesar_cipher.rb Hello 1
#   (prints "Ifmmp")
# ruby ceaser_cipher.rb "What a string!" 5
#   (prints "Bmfy f xywnsl!")
module Caesar
  def self.caesar_cipher(msg, shift)
    shift %= 26
    msg_array = msg.split('')

    new_msg = msg_array.map do |char|
      char = char.ord

      if char >= 'A'.ord && char <= 'Z'.ord
        char += shift
        char -= 26 if char > 'Z'.ord
      elsif char >= 'a'.ord && char <= 'z'.ord
        char += shift
        char -= 26 if char > 'z'.ord
      end

      char.chr
    end

    new_msg.join
  end
end

puts Caesar.caesar_cipher(ARGV[0], ARGV[1].to_i) unless ARGV[0].nil? || ARGV[1].nil?
