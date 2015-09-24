def corners(spiral)
   bottom_right = spiral**2
   bottom_left = spiral**2-(spiral-1)
   top_left = bottom_left-(spiral-1)
   top_right = top_left - (spiral-1)
   return bottom_right, bottom_left, top_left, top_right
end

def get_number(size, x, y)
   center = (size.to_f/2).ceil
   spiral = [((center-y).abs*2)+1, ((center-x).abs*2)+1].max
   corner = size-(size-spiral)/2
   dx, dy = corner-x, corner-y
   br, bl, tl, tr = corners(spiral)  
   
   case
   when dy == 0 
      return br-dx
   when dx == spiral-1 && dy != 0
      return bl-dy
   when dy == spiral -1 && dx != 0
      return tl-((corner-spiral+1)-x).abs
   else
      return tr-((corner-spiral+1)-y).abs
   end
end

def get_coordinates(size, number)     
   spiral = (number**(0.5)).ceil
   spiral += 1 if spiral % 2 == 0
   br, bl, tl, tr = corners(spiral)  
   corner = size-(size-spiral)/2
   
   case number 
   when bl..br
      return corner-(br-number), corner
   when tl..bl
      return corner-spiral+1, corner-(bl-number)
   when tr..tl
      return corner-spiral+1+(tl-number), corner-spiral+1
   else 
      return corner, corner-spiral+1+(tr-number)
   end
end


f = File.open("input.txt")
size = f.readline.chomp.to_i
numbers = f.readline.chomp.split(" ").map{|n| n.to_i}
if numbers.length == 1
   puts get_coordinates(size, numbers[0])
else
   puts get_number(size, numbers[0], numbers[1])
end
