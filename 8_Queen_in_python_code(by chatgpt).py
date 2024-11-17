def print_board(board):
    print('  a b c d')
    for i, row in enumerate(board, start=1):
        print(f'{i} ' + ' '.join('*' if cell else '.' for cell in row))

def solve_n_queens(n, board, col, solutions):
    if col == n:
        solutions.append([row[:] for row in board])
        return
    for i in range(n):
        if is_safe(n, board, i, col):
            board[i][col] = 1
            solve_n_queens(n, board, col + 1, solutions)
            board[i][col] = 0

def find_all_solutions(n):
    board = [[0]*n for _ in range(n)]
    solutions = []
    solve_n_queens(n, board, 0, solutions)
    for i, solution in enumerate(solutions):
        print(f'Solution {i+1}:')
        print_board(solution)
        print()

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

find_all_solutions(8)