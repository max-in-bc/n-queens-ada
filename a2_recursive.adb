-- a2_recursive.adb : Solution to n-Queens problem using recursion (based on Wirth)
-- Legacy Systems - CIS*3190 (DE)
-- Assignment 2 - M. Wirth
-- Due: Feb 20, 2013
-- Author: Max Gardiner

with Ada.Command_line; use Ada.Command_Line;
with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;

-- USAGE:
--      ./a2_recursive n : where n is an integer > 1
-- STEPS (SIMPLIFIED):
--      1) will ask for the name of an output file to create
--      2) initialize selection of positions for 1..n-th queen:
--      3) make next selection; if safe then place queen
--      if n placed queens is equal to n, then:
--          5a) print solution to stack and start over
--      else:
--          5b) increment cell and go to 3)

procedure a2_recursive is

	nQueens : constant integer := Integer'Value(Argument(1));       -- nQueens based on first cmd line arg
	count, temp : integer := 0;                                     -- solution count, temp vars
	row : array(1..nQueens) of integer;                             -- index = queen x point; value = queen y point
	aPointer : array(1..nQueens) of boolean;                        -- temporary index for verticle collision
	bPointer : array(2..nQueens*2) of boolean;                      -- temporary index for horizontal collision
	cPointer : array(-(nQueens - 1)..(nQueens - 1)) of boolean;     -- temporary index for diagonal collision
	fp : file_type;                                                 -- output file pointer
	filename : String(1 .. 50);                                     -- output file name
		
    --  return solution in human readable format to filename
	procedure print_grid(count : in out integer) is         -- Prints current solution saved in row array
	begin
        
        -- Increment solution count and print solution header
		count := count + 1;     
		new_line(fp);put(fp, Integer'image(count)); put(fp,":");new_line(fp);   
		
        -- for each column
		for i in 1 .. nQueens loop
			
            -- Place an empty space for every point before the Queen in current row
			for j in 1 .. row(i)-1 loop
				put(fp, ". ");
			end loop;
			
            -- Place queen at the current position
			put(fp, "Q ");
			
            -- Place an empty space for every point after the Queen in current row
			for j in row(i)+1 .. nQueens loop
				put(fp, ". ");
			end loop;
			
            -- Place new line for next row
			new_line(fp);
		
		end loop;
	end print_grid;
	
    -- return all solutions by starting the first queen from each point, and recursively finding each subsequent solution
	procedure try_spot(i : in integer) is       -- Recursively traverse rows and place queens and print solutions
	begin
    
        -- for each column
		for j in 1 .. nQueens loop
        
            -- Wirth's if statement formatted for ada; checks for diagonal, vertical, and horizontal collision
			if ((aPointer(j) = true) and (bPointer(i+j) = true) and (cPointer(i-j) = true)) then
				
                -- Setting collision points for new queen
				row(i) := j;
				aPointer(j) := false;
				bPointer(i+j) := false;
				cPointer(i-j) := false;
                
                -- if the number of queens placed is less than nQueens then recall try with incremented column
				if ( i < nQueens) then
					try_spot(i+1);
                    
                -- if the number of queens placed is equal to nQueens then print solution to file
				else
					print_grid(count);
				end if;
				
                -- Reset collision points after solution is found
				aPointer(j) := true;
				bPointer(i+j) := true;
				cPointer(i-j) := true;
				
			end if;
		end loop;
	end try_spot;

begin

    -- Print intro and get name of output file
	new_line;put("Welcome to the" & Integer'image(nQueens) & "-Queens Solver");new_line;
	put("Please enter the filename to save solutions to: ");
	Get_Line (filename, temp);
	
    -- Create and point to filename file
	create(fp, out_file, filename(1 .. temp));
	
    -- Set vertical collision array to default
	for i in 1 .. nQueens loop
		aPointer(i) := true;
	end loop;
    
    -- Set horizontal collision array to default
	for i in 2 .. nQueens*2 loop
		bPointer(i) := true;
	end loop;
    
    -- Set diagonal collision array to default
	for i in -(nQueens - 1) .. (nQueens - 1) loop
		cPointer(i) := true;
	end loop;
	
    -- Initial call to recursive function will start at very first point in matrix
	try_spot(1);
	
     -- Print number of solutions found and output file name
	put(count);put(" Solutions found and printed to " & filename(1 .. temp));
  
end a2_recursive;