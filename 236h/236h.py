from parse import matrix

def balance(equation):
   matrix(equation)

def main():
   for line in open("236h.txt").readlines():
      print(line.split("\n"))
      balance(line.split("\n")[0])
      print("_______")
      
      
if __name__ == "__main__":
   main()
   
   
   
