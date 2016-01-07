require_relative 'ShortenedDictionary'
require_relative 'Hinter'


class Game
   def initialize(dictionary, level)
      @dictionary = ShortenedDictionary.new.get_dictionary(dictionary, level)
      @level = level
      @word = @dictionary.sample
      @hints = Hinter.new(@dictionary, level, @word).get_hints
      @lives = 5
   end
   
   #Counts the matches between what the player entered
   #and the correct workd
   def score(player_input)
      score = 0
      @word.split("").each_index do |i|
         if i < player_input.length  
            score += 1 if player_input[i] == @word[i]
         else 
            break
         end
      end
      return score
   end
   
   #Plays the game
   def play
      win = false
      @hints.each {|h| puts h.upcase}
      
      while @lives > 0 || win 
         print "Guess (#{@lives} left)?"; input = gets.chomp.downcase
         if input == @word 
            puts "WINNAR!"
            win = true
         else
            puts "#{score(input)}/#{@word.length} correct"
            @lives -=1
         end
      end
      
      puts "The word was #{@word}" if !win
      
   end
end

def main
   dictionary = File.open("enable1.txt").map{|line| line.chomp}
   loop do 
      puts "Choose a level from 1-5"
      level = gets.chomp.to_i
     
      if level.between?(1, 5)
         g = Game.new(dictionary.dup, level)
         g.play
      else
         puts "invalid entry"
      end
   end
end

main