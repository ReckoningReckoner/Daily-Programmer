#Parses a chemical equation and converts into a dictionary.
#
# E.g.
# Ca(OH)2 + H3PO4 -> Ca3(PO4)2 + H2O
# [{'O': 2, 'Ca': 1, 'H': 2}, {'O': 4, 'P': 1, 'H': 3}]
# [{'O': 8, 'P': 2, 'Ca': 3}, {'O': 1, 'H': 2}]
# 
# FeCl3 + NH4OH -> Fe(OH)3 + NH4Cl
# [{'Cl': 3, 'Fe': 1}, {'O': 1, 'N': 1, 'H': 5}]
# [{'O': 3, 'H': 3, 'Fe': 1}, {'N': 1, 'H': 4, 'C': 1}]

#returns the coefficient of a bracketed vaule
def coefficient(i, reactant):
   while reactant[i] != ")":
      i += 1      
   return find_corresponding_number(i+1, reactant)
   
#Used with the reactant_dict method. When an element is
#found within an a string, it returns the value of said
#element.
def find_corresponding_number(i, reactant):
   num = ""   
   while i < len(reactant) and "0" <= reactant[i] <= "9":
      num += reactant[i]
      i += 1
      
   return 1 if num == "" else int(num)
   
# Returns a dictionary mapping a reactant with the number of 
# times it occurs. E.g. C5H12 = {'C': '5', 'H': '12'}. 
# Two special cases:
#     1. Brackets
#        Values that are in brackets need to be multiplied by
#        a coefficient. Thoses values have a '(' char when stored
#        in elements, so they are handled that way.
#     2. Duplicates
#        HNH4 Note the two H's. To counteract this problem, I've
#        decided to attatch each element with a unique key so there
#        can be some differentiation between them. The other thing
#        I've done is to rewrite prechecked elements in the list with
#        '*' characters, so they aren't checked multiple times.
def reactant_to_dict(reactant, elements):
   element_dict = {}   
   reactant = list(reactant)
   unique_key = 0 #so each element gets a unique value
   
   for item in elements:
      #bracketed elements are stored as "(Aa", so this removes the breacket.
      element = item[1:len(item)] if item[0] == "(" else item

      #checks reactant for the element
      for i in range(len(reactant)-len(element)+1): 
         if reactant[i:i+len(element)] == list(element): 
            
            # find coeffcient if bracketed element
            c = coefficient(i, reactant) if item[0] == "(" else 1 
            
            # number of times element occurs*coeffcicient
            number = c * find_corresponding_number(i + len(element), reactant)
            
            #Assign element key to count. unique_key is used here.
            element_dict[element + str(unique_key)] = number
            
            #overwrite characters that have already been read.
            for j in range(i, i + len(element)):
               reactant[j] = "*"
            
            break 
            
      unique_key += 1 #keeping thing unique

   return element_dict
            
# returns list of individual element per reactant:
# if C5H12, returns ['C', 'H']. Order of elements
# is in the order they appear. Parses through letters
# in string. If capital letter, it's a new element. Then
# all that needs to be checked is the letter after that.
# If the next letter is lowercase, then it's part of the
# element. 
# NOTE: Values in brackets will have a bracket before their
# name. E.g. P(PO4) => ["P", "(P", "(O"]
def get_elements(reactant):
   all_elements = []
   element = "" 
   in_bracket = False
   for i in range(len(reactant)):
      
      if reactant[i] == "(": 
         in_bracket = True
      elif reactant[i] == ")": #no longer within a bracket
         in_bracket = False
      elif "A" <= reactant[i] <= "Z": #is a new element
         
         element = ""
         element += reactant[i]
         
         #check the next letter (if element is two letters long)
         if i+1 < len(reactant) and "a" <= reactant[i+1] <= "z" : 
            element += reactant[i+1]
         
         #marking element as bracketed
         element = "(" + element if in_bracket else element
         
         all_elements.append(element)
      
   return all_elements
                  
#Keeps all non-integer characters within a string
def remove_numbers(string):
   new = ""
   for letter in string:
      if "A" <= letter.upper() <= "Z":
       new += letter
   return new
   
# Takes dictionary as parameter.
#
# Converts:
# [{'C0': '5', 'H1': '10', 'H2': 2}, {'O0': '2'}] 
#
# into:
# [{'C': '5', 'H': '12'}, {'O': '2'}]
def merge_uniques(with_uniques):
   merged = {}
   for k in with_uniques:
      element = remove_numbers(k)
      if element in merged:
         merged[element] += with_uniques[k]
      else:
         merged[element] = with_uniques[k]
   

   return merged
   
#Converts an equation into a dictionary containing the 
#element and the number of them. If the equations is:
# H2C5H10 + O2
# It will return:
# [{'C0': '5', 'H1': '10', 'H2': 2}, {'O0': '2'}] (The numbers next
# to the element name are for reasons stated in reactant_to_dict)
#
# Then, that dict is modified into:
# [{'C': '5', 'H': '12'}, {'O': '2'}]
#
# That is stored in reactants.
def equation_to_dict(equation):
   reactants = []
   equation = equation.split(" + ")   
   for reactant in equation:
      with_uniques = reactant_to_dict(reactant, get_elements(reactant)) 
      reactants.append(merge_uniques(with_uniques))
         
   return reactants

def extract(dictionary):
   return


#Reads input and converts it into a data structure that 
#is easier to solve mathematically.
def parse(equation):
   ls, rs = equation.split(" -> ")
   l, r = equation_to_dict(ls), equation_to_dict(rs)
   print(l, r)
   return [extract(l), extract(r)]
   
   
def matrix(equation):
   parse(equation)
   
