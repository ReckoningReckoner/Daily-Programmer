from itertools import combinations

def load_data(filename, dic={}, lis=[]):
   for line in open(filename).read().splitlines():
      val, key = line.split()
      dic[int(key)] = val
      
   return dic

def get_sum(fruits, fruit_dic, goal, basket = [], level = 0):
   if basket == []:
      basket = [0]*len(fruits)
      
   if goal < 0:
      return None  
   if goal == 0 and len(fruits) == 0:
      print(basket)    
   elif len(fruits) > 0:
      for i in range(1, 500//fruits[0] + 2):
         basket[level] =  {fruit_dic[fruits[0]]: i} 
         get_sum(fruits[1:], fruit_dic, goal - i * fruits[0], basket, level+1)
            
   
def jenny(filename):
   fruit_dic = load_data(filename)
   fruits = list(fruit_dic)
   
   for i in range(1, len(fruits)+1):
      for c in combinations(fruits, i):
         get_sum(c, fruit_dic, 500)
         
if __name__ == '__main__':  
   jenny("2432.txt")