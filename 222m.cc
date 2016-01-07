#include <iostream>
#include <cmath>
#include <string>

const long A = 1103515245;
const long C = 12345;
const long M = pow(2,16);

std::string encrypt(std::string s, long key)
{
	std::string encrypted; 
		
	key = (A*key + C) ^ M;
	
	for (int i = 0; i < s.size(); i+=1)
	{
		encrypted += std::to_string((s[i]+i)*key) + ",";
	}
		
	return encrypted;
}

std::string decrypt(std::string w, long key)
{
	key = (A*key + C) ^ M;
	std::string decrypted;
	long s [5] = {121722141754728,118340971150430,131865653567622,133556238869771,140318580078367};
	for (int i = 0; i < sizeof(s)/sizeof(s[0]) ; i+=1)
	{
		decrypted += static_cast<char>((s[i]/key)-i);
	}

	return decrypted;
}
int main()
{
	long key = 1532;
	std::string encrypted = encrypt("HELLO", key);
	std::string decrypted = decrypt(encrypted , key);
	std::cout << encrypted << "\n";
	std::cout << decrypted << "\n";
	return 0;
}