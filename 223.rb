def problem(word, bad)
   return word.split("").keep_if {|letter| bad.include?(letter)}.join == bad
end


puts problem("synchronized", "snond") 
puts problem("misfunctioned", "snond")
puts problem("mispronounced", "snond")
puts problem("shotgunned", "snond") 
puts problem("snond", "snond") 