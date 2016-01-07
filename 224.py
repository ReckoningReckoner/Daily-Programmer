def generate(file_name):
    w_max = 0
    plane = []

    with open(file_name) as f:
        for line in f:
            plane.append(list(line.rstrip('\n')))
            if w_max < len(plane[-1]):
                w_max = len(plane[-1])

    for row in plane:
        for i in range(w_max-len(row)):
            row.append(" ")

    return plane, len(plane), len(plane[0])
    
    
def check_down(y1,x1,h,w,plane):
    count = 0
    for y2 in range(y1+1, h):
        if plane[y2][x1] == " ":
            return count
        elif plane[y2][x1] == "+":
            count += check_left(y1,y2,x1,h,w,plane)

    return count
    
    
def check_left(y1,y2,x1,h,w,plane):
    count = 0
    for x2 in range(x1+1, w):
        if plane[y2][x2] == " " or plane[y1][x2] == " ":
            return count
        elif plane[y2][x2] == "+" and plane[y1][x2] == "+":
            count += check_up(y1,y2,x2,plane)
            
    return count
    
def check_up(y1, y2, x2, plane):         
    for check_y in range(y1, y2+1):
        if plane[check_y][x2] == " ":
            return 0
    return 1

def count_squares(plane, h, w):
    count = 0
    for y1 in range(h-1):
        for x1 in range(w-1):
            if plane[y1][x1] == "+": 
                count += check_down(y1,x1,h,w,plane)
                                
    return count
    
    
def main():
    plane, h, w = generate("224m3.txt")
    print(count_squares(plane, h, w))

if __name__ == "__main__":
    main()
