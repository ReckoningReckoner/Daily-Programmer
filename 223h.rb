num = gets.chomp.to_i
t = Time.now
points = [[0,0],[1,0]]
puts "0, 0\n1, 0"

num.times do |n|
   x_d = points[-1][0]-points[-1][1]
   y_d = points[-1][1]+points[-1][0]
   sum = [1, 0]
   (2**n-1).downto(0) do |i| 
      points << [points[i][1]+x_d, -points[i][0]+y_d]
      puts "#{points[-1][0]} #{points[-1][1]}"
   end
end

puts Time.now-t