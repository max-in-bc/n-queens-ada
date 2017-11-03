    n-Queens Puzzle Solver
    Author: Max Gardiner
    NOTE:  You must run my program as ./a2_[stack|recursive] n; where n is the size puzzle to solve
    RUN: 
            $ ./a2_stack 8          --nQueens == 8
                or
            $ ./a2_recursive 10     --nQueens == 10
    
    //Table of Contents//
    
        i) Intro to Puzzle
        ii) List of Files & Uses
        iii) Comparison of Algorithms
        iv) Summary of Recursive Algorithm
        v) Summary of Stack Algorithm
        
    \\Table of Contents\\
    
-----------------------------------------------------------------------------------------------------------
    
i//  Intro To Puzzle

    Place n Queens on an n by n chess board in such a way that no queen checks against any other queen.
    Design and implement two Ada programs for solving the 8-Queens problem. One should be solved using
    both a non-recursive back-tracking type algorithm which uses an ADT such as a stack (design and
    create an ADA package), and the other using a recursive algorithm (Wirth). Compare the two approaches
    from the point of view of easy of implementation/translation and efficiency
    
-----------------------------------------------------------------------------------------------------------
    
ii//  List of Files and Uses

    a2_recursive.adb : Recursive solution based on Wirth (1976)
    a2_stack.adb : Stack based back-tracking non-recursive solution based on Stack-Algorithm.pdf
    stack.ads : Stack ADT header based on the one provided in your notes
    stack.adb : Stack ADT body based on the one provided in your notes
    README.txt : Information on algorithms
    Stack-Algorithm.pdf : University of Colorado Computer Science lesson detailing stack nQueen algo
            
    **For recursive solution just switch instances of "stack" with "recursive"
    STEP (1): $ gnatmake a2_stack.adb
    STEP (2): $ ./a2_stack n                //where n is num Queens to be placed
    STEP (3): Enter filename to save to
    STEP (4): Program ends and solutions of n-Queens puzzle is saved to output file
    
-----------------------------------------------------------------------------------------------------------
            
iii//  Comparison of Algorithms

    Easy Implementation:
    Goes to the recursive (Wirth) solution because it is a very prominent algorithm on the internet, and
    even if you could not find a solution you like, it is simple enough to implement from scratch in most
    languages (especially if you can choose array indices)
    
    Efficiency:
    Based on time trials the efficiency goes to the recursive solution by far. When solving for 15 queens the
    solutions (2279184) were finished within 2 minutes, whereas the stack solution was still running when I
    cancelled it 8 minutes later.   
    
    
-----------------------------------------------------------------------------------------------------------

iv//  Summary of Recursive Algorithm

    The recursive solution is based off of Wirth's algorithm and is basically a translation of your fortran
    version. Wirth's algorithm goes as follows:
    
        1)  Start recursive function with default value of x (1)
        2)  For each column in matrix:
        
            If "point is safe" from collision then:
                3) Select next position candidate
                4) Set queen
                
                    If number of queens placed equal to row size then:
                        5) Record solution
                    Else:
                        5) Increment x and recursively call recursive function (goto 1)
                    
    
    
    Using the following arrays for checking if "point is safe":
    
    row : array [1..n] of integer;
    aPointer :	array [1..n] of boolean;
    bPointer :	array [2..2n] of boolean;
    cPointer :	array [1-n..n-1] of boolean;

    where:    
    row[i] denotes the position of the queen in the ith column;
    aPointer[j] means no queen lies in the jth row;
    bPointer[k] means no queen occupies the kth minor diagonal;
    cPointer[k] means no queen occupies the kth major diagonal.

-----------------------------------------------------------------------------------------------------------

iv//  Summary of Stack Algorithm

    The technique is called backtracking. The key feature is that a stack is used to keep track of each
    placement of a queen. Each time the program decides to place a queen on the board, the position of
    the new queen is stored in a record which is placed in the stack. We also have an integer variable to
    keep track of how many rows have been filled so far.
    
    1) Initialize a stack where we can keep track of our decisions.
    2) Place the first queen, pushing its position onto the stack and setting filled to 0.
    3) For each coordinate on matrix:
        If there are no conflicts with the queens, then:
        
            If stack size is equal to row size then:
                4) Print solution to file
            Else:
                4) Push point on stack, and increment row count
                
        else if there is room and column pointer on row is still less than row size:
            4) Continue to next iteration
            
        else:
            4) Backtrack by popping last point off stack, thereby shifting back down a row
            5) Increment column and continue to next iteration
            
            
-----------------------------------------------------------------------------------------------------------
