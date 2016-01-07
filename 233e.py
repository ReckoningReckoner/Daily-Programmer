from random import randint

class House:
   def __init__(self, filename):
      self.data = []
      self.house = []
      self.input_data(filename)
      
   #inputs the file into an array of arrays called self.data
   #Also makes the array rectangular shaped. i.e. all arrays 
   #within self.data have the same length from appending space
   #characters into them.
   def input_data(self, filename):
      file = open(filename)
      max_len = 0
      for i in range(int(file.readline())):
         t = []
         for word in file.readline():
            if word == "\n":
               break
            t.append(word)
         max_len = max(max_len, len(t))
         self.data.append(t)
         
      for i in range(len(self.data)):
         while (len(self.data[i]) < max_len):
            self.data[i].append(" ")
   
   #Makes a canvas that is three times the value of data's
   #height and five times the width of data's width.
   def clear_ground(self):
      for y in range(len(self.data)*3):
         self.house.append([])
         for x in range(len(self.data[0])*5):
            self.house[y].append(" ")
               
   #Adds floors, columns, corners and windows, in that order.
   #Modifes the house array.
   def place_block(self, y, x):
      for i in range(1,4):
         self.house[y][x+i] = "-"
         self.house[y+2][x+i] = "-"
         
      for i in 0, 4:
         self.house[y+1][x+i] = "|"
      
      for i in 0, 2:
         self.house[y+i][x] = "+"
         self.house[y+i][x+4] = "+"
      
      if randint(0,2) == 1:
         self.house[y+1][x+2] = "o"
      
   #reads data and places a block at every *.
   def read_blueprint(self):
      for y in range(len(self.data)):
         for x in range(len(self.data[y])):
            if self.data[y][x] == "*":
               self.place_block(y*3, x*5)
   
   #Removes duplicated floors.
   def remove_floors(self):
      for y in range(len(self.data)-1, 0, -1):
         self.house.pop(y*3-1)
                  
   #Removes column vertically given an xcoordinate. Deletes all 
   #elements have the specific xcoordinate given as a parameter.
   def delete_upwards(self, x):
      for y in range(len(self.house)-1,-1,-1):
         self.house[y].pop(x)
         
   #Counts the numbers of +'s vertically given an x coordinate.
   #Counts from the bottom upwards. Used to determine which column
   #to delete.
   def count_floors(self, x):
      count = 0
      for y in range(len(self.house)-1,-1,-1):
         if self.house[y][x] == "+":
            count += 1
      return count
      
      
   #Removes duplicated columns. Will delete the column that has a 
   #smaller to prevent accidental removal of walls.      
   def remove_columns(self):
      for x in range(len(self.house[-1])-1, 0,-1):
         if "".join([self.house[-1][x], self.house[-1][x-1]]) == "++":
            if self.count_floors(x) <= self.count_floors(x-1):
               self.delete_upwards(x)
            else:
               self.delete_upwards(x-1)
               
   #Clears a rectangular area from | and - pieces by replacing them
   #with blanks pieces. Requires the x and y coordinates of the farthest
   #corners
   def clear_area(self, xmin, xmax, ymin, ymax):
      for x in range(xmin, xmax):
         for y in range(ymin, ymax):
            if self.house[y][x] == "|" or self.house[y][x] == "-":
               self.house[y][x] = " "
               
   #Makes a rectangle and gets rid of | pieces. Rectangle is made horizo-
   #-ntally.
   def clear_sideways(self):
      for y in range(0, len(self.house)-2, 2):
         xmin = 0
         while xmin < len(self.house[y]):
            if self.house[y][xmin] == "+":
               xmax = xmin+4
               while xmax < len(self.house[y])-1:
                  if self.house[y][xmax] == "+" and self.house[y][xmax+1] == " ":
                     break
                  xmax +=4
                      
               self.clear_area(xmin+1,xmax,y+1,y+2)
               xmin = xmax+1
            else:
               xmin += 1

   #Makes a rectangle and gets rid of - pieces. Rectangle is made verti-
   #-cally.
   def clear_downwards(self):
      for x in range(0, len(self.house[0])-4, 4):
         ymin = 0
         while self.house[ymin][x+1] != "-":
            ymin += 2
         
         xmax = x+4
         while self.house[ymin][xmax] != "+" and self.house[-1][xmax] != "+":
            xmax += 4
         self.clear_area(x+1,xmax,ymin+1,len(self.house)-1)
         
   def get_neighbours(self, y, x):
      string = ""
      if x+1 < len(self.house[0]):
         string += self.house[y][x+1]
      if x-1 > 0:
         string += self.house[y][x-1]
      if y+1 < len(self.house):
         string += self.house[y+1][x]
      if y-1 > 0:
         string += self.house[y-1][x]
      return string.strip()

   #gets rid of all the floating plus signs. + signs with no neighbours
   #get replaced with blanks, + signs with non corner neighbours get re-
   #-places by the proper peice        
   def remove_plus(self):
      for y in range(len(self.house)):
         for x in range(len(self.house[y])):
            if self.house[y][x] == "+":
               s = self.get_neighbours(y, x)
               if len(s) == 0:
                  self.house[y][x] = " "
               elif s == "||":
                  self.house[y][x] = "|"
               elif s == "--":
                  self.house[y][x] = "-"
                  
                  
   #Draws the roof on the house. Given an xmin and xmax, this method starts
   #placing / and \ pieces to form a roof. Each / movees one up and one to 
   #the right every itereation. The \ piece does the opposite. Keep doing this
   #until the pieces meet, then place an "A" block. Sometimes the house array
   #isn't big enough, so a blank row is added. A value called times_moved_down 
   #keeps track of the times an extra row is added. 
   def draw_roof(self, xmin, xmax, y):
      times_moved_down = 0
      while xmin < xmax:
         y -=1
         xmin += 1
         xmax -= 1
         if y < 0:
            self.house.insert(0, [" "]*len(self.house[-1]))
            times_moved_down +=1

         y = max(y, 0)
         self.house[y][xmin] = "/"
         self.house[y][xmax] = "\\"
         
      self.house[y][xmax] = "A"
      return times_moved_down
      
                  
   #Finds pairs of +'s and stores their x,y coordinates in an array. Then, the
   #roofs array is read through and the draw_roof method is called. The downshifts
   #are kept track of.
   def add_roof(self):
      roofs = []
      for y in range(len(self.house)-1):
         xmin = 0
         while xmin < len(self.house[y]):
            if self.house[y][xmin] == "+":
               xmax = xmin+1
               while xmax < len(self.house[y]) and self.house[y][xmax] != "+":
                  xmax +=1
               roofs.append([xmax, xmin, y])
               xmin = xmax+1
            else:
               xmin +=1 
         
      down_shifted = 0 #keeps track extra rows for when len(house) is  too small
      for xmax, xmin, y in roofs:
         down_shifted += self.draw_roof(xmin, xmax, y+down_shifted)
         
         
   #Adds a door at for a given x coordinate. OP says that all 
   #inputs have row of *'s, so this does not handles balcony
   #cases. Also, removes window if designated block is a door
   #block.
   def add_door(self):
      x = randint(1, len(self.house[-1])-4)
      self.house[-2][x+1] = "|"
      self.house[-2][x+2] = " "
      self.house[-2][x+3] = "|"

   def run(self):
      self.clear_ground()
      self.read_blueprint()
      self.add_door() 
      self.remove_floors()
      self.remove_columns()
      self.clear_sideways()
      self.clear_downwards()
      self.remove_plus()
      self.add_roof()
      self.add_door()
      
      for i in self.house:
         print("".join(i))
         
House("233e1.txt").run()
House("233e2.txt").run()
House("233e3.txt").run()
House("233e4.txt").run()