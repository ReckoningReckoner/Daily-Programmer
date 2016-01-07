def valid(t)
   (0..3).each { |i| return false if (t.map {|j| j[i]}.uniq.length == 2)}
   return true
end

File.read("231m1.txt").split("\n").combination(3).each do |c|   
   puts "#{c}" if valid(c.map{|i| i.split("")})
end