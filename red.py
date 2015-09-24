data = open("224m3.txt").read().splitlines()
W, H = len(max(data, key=len)), len(data)
data = [line.ljust(W) for line in data]

def find_boxes(x1, x2, y):
    N = 0
    for row in data[y:]:
        if row[x1] in " -" or row[x2] in " -":
            break
        if row[x1] == row[x2] == "+":
            if all(c != " " for c in row[x1:x2]):
                N += 1
    return N

def find_lines(x, y):
    N = 0
    nx = x+1
    row = data[y]

    while nx < W and row[nx] not in " |":
        if row[nx] == "+":
            N += find_boxes(x, nx, y+1)
        nx += 1
    return N

def main():
    N = 0
        #
    for y, row in enumerate(data):
        for x, cell in enumerate(row):
            if cell == "+":
                N += find_lines(x, y)
    print(N)

if __name__ == "__main__":
    main()