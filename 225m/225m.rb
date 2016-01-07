class Remove_columns
   def initialize(f)
      @data = f.readline.to_i.times.map {f.readline.split("")};@data[-1] << "\b"
      @removed = []
   end   
   
   def run
      remove_blocks
      remove_extra_whitespace
      display_removed
      @data.each { |line| print line.join}; print "\n"
   end
   
   def remove_blocks
      @data.each do |line|        
         to_delete, deleted_count, rm = false, 0, []
         (line.length-1).downto(0) do |i|
            to_delete = true if ["+", "|"].include?(line[i])
            if to_delete
               deleted = line.delete_at(i)
               deleted_count += 1
               rm.unshift(deleted) if !["+", "|", "-"].include?(deleted)
            end
            if ["+", "|"].include?(deleted) && deleted_count > 1
               to_delete = false
               deleted_count = 0
            end
         end  
         @removed << rm if rm.length > 0    
      end
   end
   
   def remove_extra_whitespace
      @data.each do |line|
         if line.length > 1
            line.pop; (line.length-1).downto(0) {|i| line.delete_at(i) if to_remove_space?(line, i)}
            if line[-1] ==  "-"
               line.pop
            elsif line[-1] != "\s"
               line << "\s"
            end
         end
      end
   end
      
   def display_removed
      n = []
      @removed.each_index do |i|
         if @removed[i].length == @removed[i].select {|l| l == "\s"}.length
            n << []
         else
            n[-1] += @removed[i]
         end
      end
      n.each do |line|
         (line.length-1).downto(0) { |i| line.delete_at(i) if to_remove_space?(line, i)}
         print "(#{line.join})" if line.length > 0
      end
   end
   
   def to_remove_space?(line, i)
      if line[i] == "\s" 
         return true if line[i-1] == "\s" || i == 0 || i == line.length-1
      end
   end
end


puts "Ex1: "
Remove_columns.new(File.open("1.txt")).run

puts "\nEx2: "
Remove_columns.new(File.open("2.txt")).run


puts "\nEx3: "
Remove_columns.new(File.open("3.txt")).run
