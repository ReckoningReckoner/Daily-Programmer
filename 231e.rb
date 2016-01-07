def rule_90(bin)
   bin = bin.split("")
   26.times do 
      bin.each {|i| print (i == "0") ? " " : "x"};puts ""
      t = Marshal.load(Marshal.dump(bin))
      t[0], t[-1] = bin[1], bin[-2]
      (0..bin.length-3).each {|i| t[i+1] = bin[i] != bin[i+2] ? "1" : "0"}
      bin = t
      break if  bin.count("0") == bin.length
   end
end


input = "1101010"
# input = "00000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000"
rule_90(input)