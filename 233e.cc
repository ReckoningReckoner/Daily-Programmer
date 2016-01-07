#include <iostream>
#include <vector>
#include <string>
#include <fstream>


int main()
{
   std::string line;
   std::ifstream file("223e1.txt");
   if (file.is_open())
   {
      std::cout << "YOLO" << "\n";
      while (std::getline(file, line))
      {
         std::cout << "Hello" << "\n";
         std::cout << line << "\n";
      }
      file.close();
   }
   return 0;
}