#Class for the board
#Used for adding pieces

class Go
	
def initialize(file)
	@all = []
	@w, @h = file.readline.chomp.split(" ").map{|a| a.to_i}
	@piece = file.readline.chomp			 
	@g = @h.times.map{file.readline.chomp.split("")} #Stores stuff in 2D array
	if @piece == "b"
		@other = "w"
	else 
		@other = "b"
	end
end
  	
	## 
	# Reads through 2D array
	# Finds cells that are unoccupied
	# Add player piece t ocell
	# Creates counter object, that finds the number of pieces player can remove
	def place
		@g.each_index do |y|
			@g[y].each_index do |x|
				if @g[y][x] == " "
					@g[y][x] = @piece
					@all << [
                        [x, y], 
					         Counter.new(Marshal.load(Marshal.dump(@g)),@other).points
                        ]
					@g[y][x] = " "
				end                                              
			end                                                 
		end                                                    
	end                                                       
	                                                          
	##
	#Find all combinations, return result with greatest pieces captured
	def run
		place
		l = @all.sort_by!{|a| a[1]}[-1]
		if l[1] > 0
			puts "#{l[0]}"
		else
			puts "No solution"
		end
	end
	
end

class Counter
	
	def initialize(g, other)
		@grid = g
		@other = other
		@c = 0
		@total = 0
		@repeat = true
	end
	
	
	#Picks a random point that is the opposites players piece
	#Traces through it, replacing it with a "D"
	#If a previous path of "D"'s leads to a bad area, replace it with "E"
	#Adds up the number of valid traces (aka pieces captured) on the board
	def points
		@grid.each_index do |y|
			@grid[y].each_index do |x|		
				trace(y, x)  if @grid[y][x] == @other && @repeat					
				bad_paths
				@total += @c
				@repeat = true
				@c = 0
			end
		end

		return @total
	end
	
	#Recursivley creates a path that crawls through opposite player pieces
	#Paths travelled are labled "D"
	#Method is broken if path leads to a blank spot, or path leads to a path that leads to a blank spot (path is labled with an "E")
	#Counts the number of times that crawler goes through pieces that can be removed
	def trace(y, x)
		if @repeat == false
			return
		elsif @grid[y][x] == " " || @grid[y][x] == "E"
			@c = 0
			@repeat = false
		elsif @grid[y][x] == @other
			@grid[y][x] = "D"
			@c += 1
			trace(y+1, x) if y+1 < @grid.length
			trace(y-1, x) if y-1 >= 0 
			trace(y, x+1) if x+1 < @grid[0].length
			trace(y, x-1) if x-1 >= 0 
		end
	end
	
	#Finds paths that lead to a blank spot
	#Lables those paths with an "E"
	#Actually lables ALL previous paths with an E
	def bad_paths
		if !@repeat
			@grid.each_index do |y| 
				@grid[y].each_index {|x| @grid[y][x] = "E" if  @grid[y][x] == "D"}
			end
		end
	end
	
	
end
	
file = open("/Users/Viraj/Ruby/Reddit/220m/in.rb")

go = Go.new(file)
go.run

