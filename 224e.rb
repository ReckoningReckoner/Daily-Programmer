def shuffle(input)
   input = input.split
   input.length.times do
      i, j = rand(input.length), rand(input.length)
      input[i], input[j] = input[j], input[i]
   end
   return input
end
#
# def shuffle(input)
#    return (input.split.length).times.map { input.split.delete_at(rand(input.split.length))}
# end



puts "#{shuffle("apple blackberry cherry dragonfruit grapefruit kumquat mango nectarine persimmon raspberry raspberry")}"
puts "#{shuffle("a e i o u")}"