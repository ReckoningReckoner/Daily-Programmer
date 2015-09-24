class Chains
   
   def run(filename)
      f = File.open(filename)
      @h, @w = f.readline.chomp.split(" ").map{|n| n.to_i}
      @ary = @h.times.map {f.readline.chomp.split("")}
      return count_singles
   end

   def trace(y, x)
      if y.between?(0, @h-1) && x.between?(0, @w-1) && @ary[y][x] == "x"
         @ary[y][x] = "-"
         @count +=1 
         trace(y+1, x)
         trace(y-1, x)
         trace(y, x+1)
         trace(y, x-1)
      end

   end

   def count_singles
      total = 0
      @ary.each_index do |y|
         @ary[y].each_index do |x|
            @count = 0
            trace(y, x); total += 1 if @count > 0
         end
      end
      return total
   end

end

puts Chains.new.run("/Users/Viraj/Downloads/f1c2869bd67d40c88042-63871d115bc7bf887eac5434b5c6c5494f83ba2e/50.txt")
