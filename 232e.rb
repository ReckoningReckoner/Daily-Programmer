data = File.read("232e1.txt").upcase.chars.select {|c| c.between?("A", "Z")}
puts data == data.reverse ? "Palindrome" : "Not a Palindrome"