def translate(words, hash)
   words.each {|letter| print hash[letter]}; print "\n"
end

def partition(input, pval, hash, level = 0, min = 1, index = 0, words=[])
   words = [0]*pval if words.length == 0 
         
   if level >= pval 
      return if index < input.length
      translate(words, hash)
   else
      (min..input.length).each do |i|
         return if !hash.has_key?(input[index...i])
         words[level] = input[index...i]
         partition(input, pval, hash, level+1, i+1, i, words)           
      end
   end
end

def letter_splits(input)
   hash = {}
   (1..26).each {|l| hash[l.to_s] = (l+64).chr}

   pval = (input.length.to_f/2).ceil
   (pval..input.length).each {|p| partition(input, p, decoding_hash)}
end
   
letter_splits("1234")
letter_splits("10520")
