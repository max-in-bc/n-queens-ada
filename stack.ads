-- stack.ads : header for stack ADT to be used by a2_stack.adb solution
-- Author: Max Gardiner

-- Abstract Data Type: Stack
-- - Based on the stack ADT provided in your notes I have gerrymandered it to suit the purpose of holding n-queens solutions
-- - A stack is a FILO list of elements, but peeking at the elements is possible (and necessary for my print funxtion)
package stack is

    -- Function returning current size of stack (integer from 0 .. nQueens)
	function stack_size return integer;
    
    -- Procedure for adding an element (x) to the top of the stack (also would become next item to be popped off)
	procedure push(x : in integer);
    
    -- Procedure for removing an element from the top of the stack and placing it on (x)
	procedure pop( x : out integer);
    
    -- Function will return true if the stack is at size 0
	function stack_is_empty return Boolean;
    
    -- Procedure will reset stack to size 0
	procedure reset_stack;
    
    -- Procedure will print stack in human readable format (like a chessboard)
	procedure print_stack(nQueens : in integer; count : in out integer; lastRow : in integer; filename : in String);

end stack;
