from collections import defaultdict
import fileinput


def purchases(market, goal):
    '''
    Given a market as a list of (fruit, price) pairs, return all possible
    {fruit: amount} dictionaries of which the price sums to the given goal.
    '''

    if goal == 0:
        # Trivial solution.
        return [defaultdict(int)]

    if goal < 0 or not market:
        # No solutions.
        return []

    # Else, examine the first fruit -- either take some, or don't, and
    # solve a simpler problem recursively either way.
    fruit, price = market[0]
    take = purchases(market, goal - price)
    for answer in take:
        answer[fruit] += 1
    leave = purchases(market[1:], goal)

    return take + leave

def show_answer(answer):
    clauses = []
    for fruit, n in answer.items():
        clauses.append(str(n) + " " + fruit)

    print(', '.join(clauses))

if __name__ == '__main__':
    market = []
    for line in open("2431.txt"):
        fruit, price = line.split()
        market.append((fruit, int(price)))

    for answer in purchases(market, 500):
        show_answer(answer)