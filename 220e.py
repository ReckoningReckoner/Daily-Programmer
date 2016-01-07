def sort_sentence(sentence):

    line = list(sentence.split(" "))

    string = ""

    for l in line:

        k = list(l)

        punctuation, capitals = [], []

        for i in range(len(k)-1, -1, -1):
            if (ord(k[i]) >= 32 and ord(k[i]) <= 47 or #ASCII if punctuation
                ord(k[i]) >= 58 and ord(k[i]) <= 64):
                punctuation.append([k[i], i])
                k.pop(i)
            elif ord(k[i]) >= 65 and ord(k[i]) <= 90: #ASCII if uppercase
                capitals.append(i) 

        s = sorted(list(''.join(k).lower()))
                
        for p in reversed(punctuation):
            s.insert(p[1], p[0])
        for c in capitals:
            s[c] = s[c].upper()
        for i in range(len(s)):
           string += s[i]
           
        string += " "

    return string


print (sort_sentence("Eye of Newt, and Toe of Frog, Wo-Ol of Bat, and Tongue of Dog."))
