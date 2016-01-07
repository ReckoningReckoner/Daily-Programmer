#include <iostream>
#include <string>
#include <vector>

class Langford
{
   public:
      Langford(int);
      void generate();
      bool can_place(std::string, int, int);
      std::string place(std::string, int, int, int);
      void recurse(std::string, int);
   private:
      std::string string;
      std::vector<std::vector<int> > letters;
};

Langford::Langford (int n)
{
   for (int i = 0; i < n; i++)
   {
      std::vector<int> v;
      v.push_back(65+i);
      v.push_back(i+2);
      letters.push_back(v);
      string += '-';
   }
   
   for (int i = 0; i < n; i++)
      string += '-';
}

void Langford::generate() {recurse(string, 0);}

bool Langford::can_place(std::string string, int i, int dist)
{
   return string[i] == '-' && string[i+dist] == '-';
}

std::string Langford::place(std::string string, int i, int dist, int letter)
{
   string[i] = static_cast<char>(letter);
   string[i+dist] = static_cast<char>(letter);
   return string;
}

void Langford::recurse(std::string string, int level)
{
   if (level < string.length()/2)
      for (int i = 0; i < string.length()-letters[level][1]; i++)
         if (can_place(string, i, letters[level][1]))
            recurse(place(string, i, letters[level][1], letters[level][0]), level+1);
   else
      std::cout << string << "\n";
}

int main()
{
   std::cout << "Enter a number" << "\n";
   int input;
   
   while (true)
   {
      std::cin >> input;
      if (input % 4 == 0 || (input+1) % 4 == 0 || input < 4)
         break;
      std::cout << "None" << "\n";
   }
   Langford(input).generate();
   return 0;
}
