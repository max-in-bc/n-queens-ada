-- stack.adb : body for stack ADT to be used by a2_stack.adb solution
-- Author: Max Gardiner

with Ada.Text_IO; use Ada.Text_IO;

-- Abstract Data Type: Stack
-- - Based on the stack ADT provided in your notes I have gerrymandered it to suit the purpose of holding n-queens solutions
-- - A stack is a FILO list of elements, but peeking at the elements is possible (and necessary for my print funxtion)
package body stack is

	type list is array(1..1000) of integer;         -- the actual array that will act as a stack
	type int_stack is                               -- struct containing actual stack, and integer of stack size
		record
			item : list;
			top : natural := 0;
		end record;
	st : int_stack;                                 -- stack variable
	
    -- returns stack size as integer
	function stack_size return integer is
	begin
		return st.top;
	end stack_size;

    -- push integer (x) on to top of stack
	procedure push(x : in integer) is
	begin
        
        -- if the stack is full then do not push (x)
		if st.top = 1000 then
			put_line("stack is full");
            
        -- otherwise increment the stack size and push (x) to the current end of the array
		else
			st.top := st.top + 1;
			st.item(st.top) := x;
			
		end if;
	end push;
	
    -- pop integer from top of stack to integer (x)
	procedure pop( x : out integer) is
	begin
        
        -- if the stack is empty then do not pop to (x)
		if st.top = 0 then
			put_line("1stack is empty");
            
        -- otherwise decrement the stack size and move the current end of the array to (x)
		else
			x := st.item(st.top);
			st.top := st.top - 1;

		end if;
	end pop;

    -- returns true if stack size is 0; false otherwise
	function stack_is_empty return Boolean is
	begin
		return st.top = 0;
	end stack_is_empty;

    -- reset stack end pointer to 0 (threrby resetting the stack)
	procedure reset_stack is
	begin
		st.top := 0;
	end reset_stack;

    -- print solution contained in stack in human readable format to the output file
	procedure print_stack(nQueens : in integer; count : in out integer; lastRow : in integer; filename : in String) is 
	
    fp : file_type;     -- pointer to output file
	
	begin
        
        -- Reopen file created in main program and append new solution
		open(fp, append_file, filename);
        
		-- Increment solution count and print solution header
        count := count + 1;
		put(fp, Integer'image(count)); put(fp,":");new_line(fp);

        -- for each column in matrix
		for i in 1 .. nQueens loop
        
            -- set placement of last row queen
			st.item(nQueens) := lastRow;
            
            -- for each row in matrix
			for j in 1 .. nQueens loop
				
                -- if the queen's row value is equal to the current row iteration then print queen
				if(st.item(i) = j) then
					put(fp,"Q ");
                    
                -- otherwise print open space on chessboard
				else
					put(fp,". ");
				end if;
                
			end loop;
            
            -- New line for next row of chessboard
			new_line(fp);
		end loop;
        
        -- New line for next solution
		new_line(fp);
		close(fp);
        
	end print_stack;

end stack;

