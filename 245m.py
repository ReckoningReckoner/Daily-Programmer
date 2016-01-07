ALPHABET = "abcdefghijklmnopqrstuvwxyz"


def get_dict(k):
   dic = {}
   for i in range(0, len(k), 2):
      dic[k[i+1]] = k[i]
      
   return dic
   
def decode(key, message):
   dic = get_dict(key.split(" "))
   decoded = ""

   i = 0
   while i < len(message):
      if message[i].lower() not in ALPHABET:
         decoded += message[i]
      else:
         for key in dic:
            if message[i:i+len(key)] == key:
               decoded += dic[key]
               i += len(key)-1
               break
      i += 1
      
   return decoded
   
def encode(message):
   word_freq = {}
   number_of_letters = 0
   for letter in message:
      if letter.lower() in ALPHABET:
         if letter in word_freq:
            word_freq[letter] += 1
         else:
            word_freq[letter] = 1
            number_of_letters += 1
            
   
   print(number_of_letters)
   print(word_freq)

def main():
   data = open("245m.txt")
   key = data.readline().rstrip()
   message = data.read()
   print(decode(key, message))
   # m = "Hello World. I am Viraj Bangari, and I am great!"
   # encode(m)
   
main()