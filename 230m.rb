require 'deep_clone'

class Array
   def left_nils
      c = 0
      self.each_index { |i| self[i] == nil ? c += 1 : (return c)}
   end
   
   def right_nils
      c = 0
      (self.length-1).downto(0) { |i| self[i] == nil ? c += 1 : (return c)}
   end
   
   def first_non_nil
      self.each_index{|i| return i if self[i] != nil}
   end
   
   def above_nils(x)
      c = 0
      self.each_index{|i| self[i][x] == nil ? c+= 1: (return c)}
   end
   
   def below_nils(x)
      c = 0
      (self.length-1).downto(0) {|i| self[i][x] == nil ? c+= 1: (return c)}
   end
end


class Cross_Words
   def initialize(words)
      @plane = []
      @words = words
      @crosses = 0
   end
   
   def get_blanks(plane, is_y)
      plane.each_index.map { |i| {line: plane[i], y: i, is_y: is_y}}
   end
   
   def count(b, t)
      c = 0
      t.each_index do |i|
         if b[i] != nil && t[i] != nil 
            b[i] == t[i]  ? c+= 1 : (return -1)
         end
      end
      return c
   end
   
   def first_non_nil(ary)
      ary.each_with_index{|a, i| return i if a != nil}
   end
   
   def count_crosses(word, b)
      max = {count: -1, word: nil, blank: nil, full_word: nil}
      w, scroll =  word.dup + Array.new(b.length-1), Array.new(b.length)
      while w.length > 0 
         scroll.shift
         scroll << w.shift
         h = {
               count: count(b, scroll), 
               to_find: scroll.select{|i| b.include?(i)}, 
               blank: b, 
               full_word: word.join, 
               x: b.first_non_nil
             } 
         max = h if h[:count] > max[:count]
      end
      return max
   end
   
   def get_connection
      blanks = get_blanks(@plane, true) + get_blanks(@plane.transpose, false)
      max, options = {count: 0}, []
      @words.each do |w|
         blanks.each do |b|            
            c = count_crosses(w.chars, b[:line])
            if c[:count] >= max[:count]
               if c[:count] > max[:count]
                  options.clear
                  max = c
               end
               options << c.merge(b) 
            end
         end
      end
      return options
   end
   
   def horizontal(p, h, others, mode = "")
      
      h[:line] = h[:line].reverse if mode == "reverse"
 
      front_diff = others[0].length - h[:line].left_nils
      back_diff = others[1..others.length-1].flatten.length - h[:line].right_nils
      
      (0...p.length).each do |y| 
         front_diff.times { p[y].unshift(nil) }
         back_diff.times {p[y] << nil}
      end
      
      str, o = "", others.flatten
      
      start = front_diff < 0 ? 0 : front_diff
      (h[:x]+start-others[0].length...p[h[:y]].length).each do |x|
         p[h[:y]][x] = o.shift if o.length > 0 && p[h[:y]][x] == nil
         p[h[:y]][x] == nil ? str += " " : str += p[h[:y]][x]
      end

      word = mode == "reverse" ? h[:full_word].reverse : h[:full_word]
      return p if str.include?(word)
   end
   
   def vertical(p, h, others, mode = "")
      
      p = p.reverse if mode == "reverse"
      
      front_diff = others[0].length - p.above_nils(h[:x])
      back_diff = others[1..others.length-1].flatten.length - p.below_nils(h[:x])      

      front_diff.times {p.unshift Array.new(h[:line].length) }
      back_diff.times {p << Array.new(h[:line].length) }

      str, o = "", others.flatten         
      start = front_diff < 0 ? 0 : front_diff
      (h[:y]+start-others[0].length...p.length).each do |y|
         p[y][h[:x]] = o.shift if o.length > 0 && p[y][h[:x]] == nil
         p[y][h[:x]] == nil ? str += " " : str += p[y][h[:x]]
      end
      
      word = mode == "reverse" ? h[:full_word].reverse : h[:full_word]
      return p if str.include?(word)
   end
   
   
   def place(hashes)
      begin
         options = []
         hashes.each do |h|
            p = h[:is_y] ? @plane : @plane.transpose
            others = [[]]
            h[:full_word].chars.each {|i| h[:to_find].include?(i) ? others << [] : others[-1] << i}
         
            n = []
            n << horizontal(DeepClone.clone(p), h, others)
            n << horizontal(DeepClone.clone(p.map{|i| i.reverse}), h, others.map{|i| i.reverse}.reverse, "reverse")
            n << vertical(DeepClone.clone(p), h, others)
            n << vertical(DeepClone.clone(p.map{|i| i.reverse}), h, others.map{|i| i.reverse}.reverse, "reverse")
         
            n.compact!
            n.each do |i|
               options << 
               { 
                  plane: i, 
                  area: i.length*i[0].length,
                  full_word: h[:full_word],
                  count: h[:count]
               }
            end
         end
      

         options.sort_by!{|w| -w[:area]}
         @plane = options[0][:plane]
         @words.delete(options[0][:full_word])
         @crosses += options[0][:count]
      rescue
         return
      end
   end
   
   def run
      w = @words.sort_by{|word| -w.split("").length}
      t = []
      (0..w.length/2).each do |i|
         t << w[i]
         t << w[-1-i]  if i != w.length-1-i
      end
      @words = t
      puts "#{@words}"
      @plane << @words[0].chars
      @words.shift
      place(get_connection) while @words.length > 0
      @plane.each { |p| p.each {|i| print i==nil ? " " : i};print "\n"}
      puts "Crosses: #{@crosses}"
      puts "#{@plane.length} #{@plane[0].length}"
   end
end


Cross_Words.new(File.read("230m1.txt").split(",")).run
Cross_Words.new(File.read("230m2.txt").split(",")).run
Cross_Words.new(File.read("230m3.txt").split(",")).run
Cross_Words.new(File.read("230m4.txt").split(",")).run