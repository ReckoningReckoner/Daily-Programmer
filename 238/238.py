from random import choice, sample


def get_words(d):
    difficulty = {1: (4, 5, 6), 2: (7, 8), 3: (9, 10, 11), 4: (12, 13), 5: (14, 15)}

    with open('enable1.txt', 'r') as file:
        b = choice(difficulty[d])
        words = [x for x in map(str.strip, file.readlines()) if len(x) == b]
        return sample(words, b + 1)


def guess(secret, i):
    word = input('Guess (' + str(4 - i) + ' left)? ')
    return len([(x, y) for x, y in zip(secret, word) if x == y])


def play():
    d = int(input('Difficulty (1-5)? '))
    words = get_words(d)
    print('\n'.join(map(str.upper, words)))
    secret = choice(words)
    print(secret)
    l = len(secret)

    for i in range(4):
        g = guess(secret, i)
        if g == l:
            print('You win !')
            return
        else:
            print(g, '/', l, 'correct')

    print('You lose, the word was', secret)

play()
