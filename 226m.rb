class Board
   
   def initialize
      @board = 6.times.map{7.times.map{0}}
      @h = @board.length-1
   end
   
   def place_piece(x, player)
      @h.downto(0).each do |y|
         if @board[y][x] == 0
            @board[y][x] = player 
            break
         end
      end
      return Score.new(player, Marshal.load(Marshal.dump(@board))).run
   end
   
end

class Score
   
   def initialize(player, board)
      @player = player
      @board = board
      @h = board.length-1
      @w = board[0].length
   end
   
   def run
      @board.each_index do |y|
         @board[y].each_index do |x|
            c = count(y, x)
            return c if c != false
         end
      end
   end
   
   
   def count(y, x)
      if check_r(y,x)
         return true, [[y, x],[y,x+1],[y,x+2],[y,x+3]]
      elsif check_d(y,x)
         return true, [[y, x],[y+1,x],[y+2,x],[y+3,x]]
      elsif check_dl(y,x)
         return true, [[y, x],[y+1,x-1],[y+2,x-2],[y+3,x-3]]
      elsif check_dr(y,x)
         return true, [[y, x],[y+1,x+1],[y+2,x+2],[y+3,x+3]]
      else
         return false
      end
   end

   def check_r(y,x)
      c = 0
      x.upto(@w).each {|x_c| @board[y][x_c] == @player ? c += 1 : break}
      return c >= 4 
   end
   
   def check_d(y,x)
      c = 0
      y.upto(@h) { |y_c| @board[y_c][x] == @player ? c += 1 : break}
      return c >= 4 
   end
   
   def check_dl(y,x)
      i = 0
      i+= 1 while  (y+i).between?(0, @h) &&  (x-i).between?(0, @w) && @board[y+i][x-i] == @player 
      return i >= 4
   end
   
   def check_dr(y,x)
      i = 0
      i+= 1 while ((y+i).between?(0, @h) && (x+i).between?(0, @w) && @board[y+i][x+i] == @player)
      return i >= 4
   end
   
end

def winning_message(locations)
   return locations.map{|y, x| "#{(x+65).chr}#{6-y}"}.join(" ")
end

def run(filename)
   board = Board.new
   move_num = 0
   File.open(filename).each do |line|
      
      move_num += 1
      a_col, b_col = line.chomp.split("  ").map{|c| c.upcase.ord-65}
   
      b = board.place_piece(a_col, 1)
      if b[0] == true
         puts "X won at move #{move_num}"
         puts winning_message(b[1])
         break
      end
   
      b = board.place_piece(b_col, 2)
      if b[0] == true
         puts "O wins at move #{move_num}"
         puts winning_message(b[1])
         break
      end
   end
   
end

run("226m2.txt")