#Shortens a dictionary so it only has words of a certain length based
#on the level of difficulty
class ShortenedDictionary
   
   #Selects appropriate word length based
   #on user input
   def get_word_length(level)
      case level
      when 1
         4 
      when 2
         rand 4..6
      when 3
         rand 6..9
      when 4
         rand 9..12
      when 5
         rand 12..15
      end
   end
   
   #Return a dictionary with words that only 
   #have a certain length.
   def get_dictionary(dictionary, level)
      accepted_length = get_word_length(level)
      new_dict = []
      dictionary.each {|word| new_dict << word if word.length == accepted_length }
      return new_dict
   end
end