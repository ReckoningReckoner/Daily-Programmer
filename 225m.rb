class Diagonal_Reader
   def initialize(ary)
      @ary = ary
      @maze = []
   end

   def run
      diagonalize(squareify(@ary.length, @ary.max_by{|row| row.length}.length))
      display
   end

   def squareify(h, w)
      if h > w
         @ary.each {|i| i += (h-w).times.map{" "}}
      elsif w > h
         (w-h).times {@ary << w.times.map{" "}}
      end
      return @ary.length
   end
   
   def diagonalize(size)
      @maze = (2*size).times.map {(2*size).times.map{" "}}
      @ary.each_index do |y|
         @ary[y].each_index do |x|
            @maze[y+x][size+x-y] =  @ary[y][x]
         end
      end
   end

   def display
       @maze.each_index do |i|
          @maze[i].each_index do |j|
             if @maze[i][j] == "-"
                @maze[i][j] = "\\"
             elsif @maze[i][j] == "|"
                @maze[i][j] = "/"
             end
          end
          puts @maze[i].join if @maze[i].length != @maze[i].select {|s| s== " "}.length
       end
   end
end

def run(filename)
   f = File.open(filename)
   n = f.readline.chomp.to_i
   Diagonal_Reader.new(n.times.map {f.readline.chomp.split("")}).run
end

run("225m1.txt")
run("225m2.txt")
run("225m3.txt")
