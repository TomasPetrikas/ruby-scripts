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

def caesar_cipher(msg, shift)
  shift %= 26
  msg_array = msg.split("")

  new_msg = msg_array.map do |char|
    char = char.ord

    if char >= "A".ord and char <= "Z".ord
      char += shift
      if char > "Z".ord
        char -= 26
      end
    elsif char >= "a".ord and char <= "z".ord
      char += shift
      if char > "z".ord
        char -= 26
      end
    end

    char = char.chr
  end

  new_msg.join
end

puts caesar_cipher(ARGV[0], ARGV[1].to_i)