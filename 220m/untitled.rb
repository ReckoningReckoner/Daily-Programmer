class Test
    attr_accessor :g

    def initialize
        @g = [[1,2,3]]
		  @other = 12
    end

 	def do_stuff
		Test_Two.new(@g.dup).modify
 	end

end

class Test_Two
    def initialize(h)
        @h = h
    end

    def modify
        @h[0].dup[0] = "HI"
    end

end

t = Test.new
puts "#{t.g}"
t.do_stuff
puts "#{t.g}"