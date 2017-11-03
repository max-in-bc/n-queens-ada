-- a2_stack.adb : Solution to n-Queens problem using backtracking and a stack ADT for results
-- Legacy Systems - CIS*3190 (DE)
-- Due: Feb 20, 2013
-- Author: Max Gardiner

with Ada.Command_line; use Ada.Command_Line;
with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
with stack; use stack;

-- USAGE:
--      ./a2_stack n : where n is an integer > 1
-- STEPS (SIMPLIFIED):
--      1) will ask for the name of an output file to create
--      2) go through each row, placing a position on stack (queen) correctly until:
--          2a) n number of queens are placed, then solution is printed to file
--      3) if a row cannot correctly place a queen, it must backtrack one row and continue moving right

procedure a2_stack is

	nQueens : constant integer := Integer'Value(Argument(1));   -- nQueens based on first cmd line arg
	k, count, t1, t2, temp : integer := 0;                      -- backtracking integer, solution count, temp vars
	a : array(1 .. nQueens + 1) of integer;                     -- array for creating backtracking tree
	fp : file_type;                                             -- pointer to output file
	filename : String(1 .. 50);                                 -- name of output file

    -- return true if the point on the row cannot be reached horizontally, vertically, or diagonally by any other point occupied by a queen
    -- return false if point can be reached either horizontally, vertically, or diagonally by any other point occupied by a queen
    function place(pos : integer) return Boolean is     -- Check to see if placing a queen can be placed at specific point
	begin
		
        for i in 1 .. pos-1 loop
            -- if this position can be reached by any other position, return false
			if( (a(i)=a(pos)) or ((abs(a(i)-a(pos))=abs(i-pos))) ) then
				return false;
			end if;
			
		end loop;
		
        -- cannot be reached by other queens, therefore return true for good position       
		return true;
	end place;

begin
	k := k + 1;
	a(k) := 0;
	
    -- Print intro and get name of output file
	new_line;put("Welcome to the" & Integer'image(nQueens) & "-Queens Solver");new_line;
	put("Please enter the filename to save solutions to: ");
	Get_Line (filename, temp);
	
    -- Create a file to be appended to in the print_stack function
	create(fp, out_file, filename(1 .. temp));
	close(fp);
	
    -- While we have not backtracked through all possibilities, continue
	while (k /= 0) loop
        
        -- Start at the first position in the new row
		a(k) := a(k) + 1;
        
        -- Continue through each position in the row until: (A) position goes out of bounds of the row; (B) position is placeable
		while(a(k) <= nQueens and not place(k)) loop
			a(k) := a(k) + 1;
		end loop;
		
        -- if position is placeable (B)
		if (a(k) <= nQueens) then
			
            -- if we have placed a queen on each row, then print the stack
			if (k = nQueens) then
				print_stack(nQueens, count, a(k), filename(1 .. temp));
			
            -- otherwise there are still rows without queens, then push this position onto stack and move up a row
            else
				push(a(k));
				k := k + 1;
				a(k) := 0;
			end if;
		
        -- if position goes out of bounds of the row (A)	
		else
            
            -- Backtrack by popping current position off the stack, and going back down a row and to the right
			if not (stack_is_empty) then
				pop(t1);
			end if;
			k := k - 1;
		
		end if;
	end loop;
    
    -- Print number of solutions found and output file name
	put(count);put(" Solutions found and printed to " & filename(1 .. temp));
end a2_stack;
