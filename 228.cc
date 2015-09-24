#include <iostream>
#include <vector>
#include <ctime>
#include <algorithm>


bool has_dup(std::vector<int> *v, int val)
{
   for (int i = 0; i < v->size(); i +=1)
      if ((*v)[i] == val) return true;
   return false;
}

bool check_valid(std::vector<int> *ruler, int level)
{
   std::vector<int> distances;
   for (int  i = 1; i < ruler->size()-1; i += 1)
   {
      if ((*ruler)[i] != 0)
      {
         if(has_dup(&distances, (*ruler)[i] )) return false;
         distances.push_back((*ruler)[i]);  
         for (int j = i+1; j < ruler->size(); j += 1)
         {
            if ((*ruler)[j] != 0)
            {
               if(has_dup(&distances, (*ruler)[j] - (*ruler)[i])) return false;
               distances.push_back((*ruler)[j] - (*ruler)[i]);
            }
         }
      }
   }
   
   
   return true;
}


void recurse(int level, std::vector<int> ruler, std::vector< std::vector<int> > * p_options)
{   
   if (level < ruler.size()-1)
   {
      for (int i = ruler[level-1]+1; i < ruler[ruler.size()-1]; i += 1)
      {
         ruler[level] = i;
         if (check_valid(&ruler, level)) 
            recurse(level + 1, ruler, p_options);
      }
   }
   else
      p_options->push_back(ruler);
}


void display(std::vector<int> ruler)
{
   std::cout << "          ";
   for (int i = 0; i < ruler.size(); i+=1)
      std::cout << ruler[i] << " ";
   std::cout << "\n";
}

void delete_pairs(int max, std::vector< std::vector<int> > *options)
{
   
   for (int i = options->size()-1; i >= 0; i-=1)
   {
      std::vector<int> pair;
      
      for (int j = (*options)[i].size()-1; j >= 0; j-=1)
         pair.push_back(max-(*options)[i][j]);
       
      for(int k = i-1; k >= 0; k-=1)
         if ((pair == (*options)[k]))
            options->erase(options->begin()+i);
   }
      
}

void generate_ruler(int len)
{
   int max = len;
   std::vector< std::vector<int> > options;
   
   while (true)
   {
      std::vector<int> ruler (len, 0);
      ruler[ruler.size()-1] = max;
      recurse(1, ruler, &options);
      if (options.size() > 0) break;
      max += 1;
   }
   
   delete_pairs(max, &options);
   
   std::cout << "Results:\n" << max;
   for_each(options.begin(), options.end(), display);   
}


int main()
{
   int len;
   std::cout << "Enter a golumb order:" << "\n";
   std::cin >> len;
   
   clock_t start, end;
   start = clock();
   generate_ruler(len);
   end = clock();
   
   std::cout << "Time:" << difftime((float)end, (float)start)/CLOCKS_PER_SEC<< "s\n";
   
   return 0;
}

