def get_data(filename)
   pairs, data = [], {}
   File.open(filename).map do |line|      
      t = {}
      line.chomp.split("").each do |letter|
         data[letter] = 0 if !data.has_key?(letter)
         if data.has_key?(letter)
            data[letter] += 1
            t[letter] = data[letter]
         end            
      end
      pairs << t
   end
   data.each_key {|k| data[k] = 1}
   return data, pairs
end

def is_greater?(last, current, data, equivalences)
   changed = false
   last_val = last[last.keys[0]]*data[last.keys[0]]
   current.each_key do |k| 
      if current[k]*data[k] <= last_val
         data[k] += 1
         changed = true
      end
      equivalences[k] = current[k]*data[k]   
   end
   return changed
end

def is_equal?(equivalences, current,data)
   changed = false
   if equivalences.values.uniq.length > 1
      max_value = equivalences.values.max
      equivalences.each_key do |k|
         if equivalences[k] < max_value
            data[k] = (max_value.to_f/current[k]).ceil
            changed = true
         end
      end 
   end
   return changed
end

def compare(last, current, data)
   eq = {}
   return is_greater?(last, current, data, eq) || is_equal?(eq, current,data)
end

def insert_missing(data, pairs)
   if data.keys.max.ord-96 != data.length
      ("a"..data.keys.max).each do |l|
         pairs.last.each { |k, v| data[l] = v*data[k]+1; break} if !data.has_key?(l)
      end
   end
   return data
end

def get_values(data, pairs)
   i = 1
   compare(pairs[i-1], pairs[i], data) ? i = 1 : i += 1 while i < pairs.length
   return insert_missing(data, pairs)
end

def reverse_fizz(filename)
   data, pairs = get_data(filename)
   puts get_values(data, pairs)
end

t = Time.now
reverse_fizz("229m1.txt")
reverse_fizz("229m2.txt")
reverse_fizz("229m3.txt")
reverse_fizz("229m4.txt")
puts "Time: #{Time.now-t}"