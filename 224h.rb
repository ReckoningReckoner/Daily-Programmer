class Langford
   
   def initialize(n)
      @string = (2*n).times.map{"-"}
      @letters = n.times.map {|i| [(65+i).chr , i+2] }
   end
   
   def generate
      recurse(@string)
   end
   
   def can_place?(string, i, dist)
      return string[i] == "-" && string[i+dist] == "-" && (i+dist).between?(0, string.length-1)
   end
   
   def place(string, i, dist, letter)
      string[i], string[i+dist] = letter, letter
      return string
   end

   def recurse(string, level=0)
      if level < string.length/2
         letter = @letters[level] 
         (0...string.length-letter[1]).each do |i|
            if can_place?(string, i, letter[1])
               recurse(place(Marshal.load(Marshal.dump(string)), i, letter[1], letter[0]), level+1)
            end
         end
      else
         puts "#{string.join}"
      end
   end
end


Langford.new(gets.chomp.to_i).generate