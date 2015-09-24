
def recurse(x, a)   
   # while x >= a do
   # x = x%7
      puts "#{x}"
   # end
   # puts "MIN: #{a} #{x}"
end

t = []
(0..5).each do |i|
   sum = 0
   (7..10**i).step(7).each { |i| sum += i if i.to_s.reverse.to_i % 7 == 0}
   t << [i, sum/7]
end

t.each do |l|
   puts "#{l}"
   recurse(l[1], l[0])
end