$dictionary = File.read("words.txt").split("\n")

class String
   def in_dictionary?
      return self.downcase if $dictionary.include?(self.downcase)
      return self.downcase.reverse if $dictionary.include?(self.reverse.downcase)
   end
end

def words_in_word(w)
   (0...w.length).each do |i|
      (0...w.length-i).each do |j|
         d = w[i..j+i].join.in_dictionary?
         return d if d != nil
      end
   end
   return 
end

def valid_words(word)
   d = word.in_dictionary?
   return d != nil ? d : words_in_word(word.split(""))
end

def get_words(logo)
   valid, words  = [], []
   logo.each{|i| i.join.split(" ").each{|w| words << w}}
   logo.transpose.each{|i| i.join.split(" ").each{|w| words << w}}
   words.each do |w| 
      v = valid_words(w)
      valid << v if v != nil
   end
   return valid
end

def decompact(filename)
   f = File.open(filename)
   logo = f.readline.to_i.times.map {|i| f.readline.chomp.split("")}
   max = logo.max_by{|l| l.length}.length
   logo.each {|l| (l.length-max).abs.times {l << " "} }
   puts "File: #{filename}" 
   puts get_words(logo)
   puts "\n"
end

decompact("230h1.txt")
decompact("230h2.txt")
decompact("230h3.txt")