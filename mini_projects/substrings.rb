# This method searches a string parameter and counts occurrences of words from
# a dictionary parameter
#
# Parameters
#
# (String, Array)
#
# Returns
#
# Hash

def substrings(string, substring_list)
  string.downcase!

  substring_list.each_with_object(Hash.new(0)) do |substring, new_hash|
    count = string.scan(substring.downcase).length
    new_hash[substring] = count unless count.zero?
  end
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

puts substrings('below', dictionary)
# {"below"=>1, "low"=>1}

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
# {"down"=>1, "go"=>1, "going"=>1, "how"=>2, "howdy"=>1, "it"=>2, "i"=>3, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1}
