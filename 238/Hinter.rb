#Finds the valid hints for a given word
#level 4 and 5 give duplicate hints which
#makes things more confusing
class Hinter
   def initialize(dictionary, level, word)
      @dictionary = dictionary
      @word = word
      @level = level
   end

   # Returns a valid hint for a given letter within a word
   def next_hint(i, letter)
      hints = []
      @dictionary.each {|word| hints << word if word[i] == letter}
      return hints.sample
   end

   def get_hints
      hints = []
      @word.split("").each_with_index {|letter, i| hints << next_hint(i, letter)}
      return hints.shuffle
   end
end