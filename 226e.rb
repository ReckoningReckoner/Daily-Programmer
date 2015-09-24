def gcd(small, large)
   i = 2
   while i <= small
      if small % i == 0 and large % i == 0
         loop do
            break if small %i != 0 || large % i != 0 
            small, large = small/i, large/i
         end
      end
      i +=1
   end
   return small, large
end

def reduce(fraction)
   if fraction[0] < fraction[1]
      return gcd(fraction[0], fraction[1])
   elsif fraction[0] == fraction[1]
      return [1,1]
   elsif fraction[0] > fraction[1]
      return gcd(fraction[1], fraction[0]).reverse
   end
end

def add_fract(first, second)
   if first[1] == second[1]
      return gcd(first[0]+second[0], first[1])
   else
      return gcd(first[0]*second[1]+second[0]*first[1], first[1]*second[1])
   end
end

f = File.open("226e1.txt")
n = f.readline.chomp.to_i
sum = [0,1]
n.times do
   sum = add_fract(sum, f.readline.chomp.split("/").map{|num| num.to_i})
end


puts "#{sum}"