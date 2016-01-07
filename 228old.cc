#include <iostream>
#include "time.h"

const int INPUT = 10;   //hardcoded for laziness

char arrayStart[1024] = {}; //big enough
//each char in the array will be 0 if it's legal to place a mark there
//or it will be set to the recursion depth at which it was made illegal

int marks[INPUT] = {};
int shortest[INPUT] = {};

void buildRuler(int i, int markNum)
{
    while (i < shortest[INPUT - 1])
    {
        if (arrayStart[i] == 0)
        {
            marks[markNum] = i;

            if (markNum == INPUT - 1)
            {
                std::copy(marks, marks + INPUT, shortest);
                return;
            }

            int distances[INPUT];
            for (int j = 0; j < markNum; ++j)
                distances[j] = i - marks[j];

            for (int j = 0; j <= markNum; ++j)
                for (int k = 0; k < markNum; ++k)
                    if (arrayStart[marks[j] + distances[k]] == 0)
                        arrayStart[marks[j] + distances[k]] = markNum;


            buildRuler(i + 1, markNum + 1);

            for (int j = 0; j <= markNum; ++j)
                for (int k = 0; k < markNum; ++k)
                    if (arrayStart[marks[j] + distances[k]] == markNum)
                        arrayStart[marks[j] + distances[k]] = 0;
        }

        ++i;
    }
}

int main()
{
    clock_t startTime = clock();
    shortest[INPUT - 1] = 1024;

    buildRuler(1, 1);

    for (int i = 0; i < INPUT; ++i)
        std::cout << shortest[i] << " ";

    std::cout << "\n" << clock() - startTime << " ms";
    std::cin.ignore();
}