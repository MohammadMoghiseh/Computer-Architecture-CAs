def solve_n_queens (n ,board , col ) :
    if col == n :
        for o in range(n) :
            print(board[o])
        return True
    for i in range (n) :
        if is_safe(n , board , i , col) :
            board [i][col] = 1
            if solve_n_queens(n , board , col +1) :
                return True
            board [i][col] = 0
    return False


def is_safe(n, board , row , col) :
    q=row
    l=col
    for m in range(n) :
        if board[row][m] ==1 :
            return False
    for p in range(n) :
        if board[p][col] ==1 :
            return False 
    for i in range(4) :
        q=row
        l=col
        while (0 <= q < n) and (0 <= l < n) :
            if board[q][l] == 1 :
                return False
            else :
                if i==0 :
                    q = q+ 1 
                    l = l+1
                elif i==1:
                    q = q + 1
                    l = l-1
                elif i==2 :
                    q = q- 1
                    l = l+1
                else :
                    q = q- 1
                    l = l-1
    return True

n=8
board = [([0]*n) for i in range(n)]
solve_n_queens (n ,board , 0 )