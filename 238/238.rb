class Difficulty
   def get_word_length(level)
      case level
      when 1
         4 
      when 2
         rand 5..6
      when 3
         rand 6..9
      when 4
         rand 9..12
      when 5
         rand 12..15
      end
   end
  
   def get_dictionary(dictionary, level)
      accepted_length = get_word_length(level)
      return dictionary.select {|word| word.length == accepted_length }
   end 
end

class Game
   def initialize(dictionary, level)
      dictionary = Difficulty.new.get_dictionary(dictionary, level)
      @word = dictionary.sample
      @hints = (dictionary.sample(@word.length-1) << @word.upcase).shuffle
      @lives = 5
   end
   
   def score(input)
      score = 0
      @word.chars.each_index { |i| score += 1 if i < input.length && input[i] == @word[i]}
      return score
   end
   
    def play
      @hints.each {|h| puts h.upcase}
      while @lives > 0
         print "Guess (#{@lives} left)?"; input = gets.chomp.downcase
         if input == @word 
            puts "WINNAR!"
            return
         else
            puts "#{score(input)}/#{@word.length} correct"
            @lives -=1
         end
      end
      puts "The word was #{@word}"
   end
end

def main
   dictionary = File.open("enable1.txt").map{|line| line.chomp}
   puts "Choose a level from 1-5"
   level = gets.chomp.to_i
   level.between?(1, 5) ? Game.new(dictionary.dup, level).play : (puts "invalid entry")
end

main