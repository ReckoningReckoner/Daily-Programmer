word = input()
print(word, "IN ORDER") if list(word.upper()) == sorted(word.upper()) else print(word, "NOT IN ORDER")