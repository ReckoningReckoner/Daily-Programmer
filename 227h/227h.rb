def trace(matrix, ary, dir, last)
   letter, y, x = ary[0], ary[1], ary[2]
   while (y+dir[0]).between?(0, matrix.length-1) && (x+dir[1]).between?(0, matrix[y].length-1)
      y += dir[0]; x += dir[1]      
      if matrix[y][x].between?('a', 'z')
         @connected << matrix[y][x]
         return
      elsif matrix[y][x] == "#"
         return check_possible_move(matrix, [letter, y, x], [dir[0]*-1, dir[1]*-1])
      elsif matrix[y][x] == " "
         return
      end
   end   
end


def check_possible_move(matrix, ary, last=[])
   letter, y, x = ary[0], ary[1], ary[2]
   trace(matrix, ary, [1,  0], last) if valid?(matrix, ary, [1,  0], last) && matrix[y+1][x] == "|" 
   trace(matrix, ary, [-1, 0], last) if valid?(matrix, ary, [-1, 0], last) && matrix[y-1][x] == "|" 
   trace(matrix, ary, [0,  1], last) if valid?(matrix, ary, [0,  1], last) && matrix[y][x+1] == "-" 
   trace(matrix, ary, [0, -1], last) if valid?(matrix, ary, [0, -1], last) && matrix[y][x-1] == "-" 
   trace(matrix, ary, [1,  1], last) if valid?(matrix, ary, [1,  1], last) && matrix[y+1][x+1] == "\\" 
   trace(matrix, ary, [-1,-1], last) if valid?(matrix, ary, [-1,-1], last) && matrix[y-1][x-1] == "\\" 
   trace(matrix, ary, [1, -1], last) if valid?(matrix, ary, [1, -1], last) && matrix[y+1][x-1] == "/" 
   trace(matrix, ary, [-1, 1], last) if valid?(matrix, ary, [-1, 1], last) && matrix[y-1][x+1] == "/" 
end

def valid?(matrix, ary, dir, last)
   letter, y, x = ary[0], ary[1], ary[2]
   return last!= dir && (y+dir[0]).between?(0, matrix.length-1) && (x+dir[1]).between?(0, matrix[y].length-1)
end

def find_letters(ary)
   a = []
   ary.each_index do |y|
      ary[y].each_index do |x|
         a << [ary[y][x], y, x] if ary[y][x].between?('a', 'z')
      end
   end
   
   return a
end

def squareify(ary, max)
   ary.each_index { |i| ary[i] << " " while ary[i].length < max}
   return ary
end

def generate(filename)
   f = File.open(filename)
   n = f.readline.chomp.to_i
   
   matrix = n.times.map {f.readline.chomp.split("")}
   matrix = squareify(matrix, matrix.max_by{|m| m.length}.length)
   letters = find_letters(matrix)
   
   letters.sort.each do |a| 
      @connected = []
      check_possible_move(matrix, a)
      gen = letters.length.times.map{0}
      @connected.uniq.sort.each { |l| gen[l.ord-97] = 1}
      puts gen.join
   end
end

generate("5.txt")
