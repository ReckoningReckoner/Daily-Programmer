def get_data(filename):
   file = open(filename)
   width, height = file.readline().rstrip().split(", ")
   
   grid = []
   for i in range(int(height)):
      grid.append(file.readline().rstrip())
      
   return int(width), int(height), grid
   
def find_x_blocks(width, height, grid):
   x_positions = []
   for y in range(height-1, -1, -1):
      for x in range(width):
         if grid[y][x] == "X":
            x_positions.append((x, y))
            
   return x_positions
   
def manhatten_distances(x_pos):
   distances = []
   for i in range(len(x_pos)-1):
      x_dist = x_pos[i+1][0] - x_pos[i][0]
      y_dist = x_pos[i][1] - x_pos[i+1][1]
      
      if x_dist < 0 or y_dist < 0:
         return None
      else:
         distances.append((x_dist+1, y_dist+1))
         
   return distances

def get_moves(width, height, moves, x = 0, y = 0):   
   if not 0 <= x < width or not 0 <= y < height:
      return 0
      
   if x == width-1 and y == height -1:
      return 1
   else:
      total = 0
      for j, k in [(1, 0), (0, 1), (1, 1)]:
         total += get_moves(width, height, moves, x+j, y+k)

      return total
      

def main(filename):
   width, height, grid = get_data(filename)
   m = manhatten_distances( find_x_blocks(width, height, grid) )
   if m == None:
      print("INVALID INPUT")
   else:
      moves = 1
      for x, y in m:
         moves *= get_moves(x, y, [0])
      print(moves)
      

main("2472.txt")