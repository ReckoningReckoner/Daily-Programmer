require 'json'
require 'deep_clone'
require 'open-uri'

class Find_Val
   def initialize(hash, val)
      @hash, @val, @paths = hash, val, []
   end

   def search(v, k, path)
      find_val(v, DeepClone.clone(path) << k) if v.instance_of?(Hash) || v.instance_of?(Array)
      @paths << (path << k) if v == @val
   end

   def find_val(obj=@hash, path = [])
      if obj.instance_of?(Hash)
         obj.each { |k, v| search(v, k.to_s, path)}
      else
         obj.each { |v|  search(v, obj.index(v), path)}
      end
   end

   def get_paths
      find_val
      @paths.each{|p| puts p.join(" -> ")}
   end
end

Find_Val.new(JSON.parse(open("https://gist.githubusercontent.com/anonymous/8f35cc4fbbccf6d3f59f/raw/1f9786fc2fec9a7afa20cdd70d2d8afb7d3aecb9/challenge1.txt").read), "dailyprogrammer").get_paths
Find_Val.new(JSON.parse(File.read("230e2.json")), "dailyprogrammer").get_paths
Find_Val.new(JSON.parse(File.read("230e3.json")), "dailyprogrammer").get_paths
Find_Val.new(JSON.parse(File.read("230e4.json")), "dailyprogrammer").get_paths
