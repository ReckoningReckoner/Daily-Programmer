puts File.open("232m1.txt").map.with_index {|line , i| line.chomp.split("")[1..line.split("").length-3].join.split(", ").map{|s| s.to_f} if i != 0}.compact.combination(2).map {|c| [Math.sqrt((c[0][0]-c[1][0])**2+(c[0][1]-c[1][1])**2), c[0], c[1]]}.min_by{|c| c[0]}


