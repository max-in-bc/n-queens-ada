-- a2_backtrack.adb : Solution to n-Queens problem using backtracking and an array for results
-- Author: Max Gardiner

with Ada.Command_line; use Ada.Command_Line;
with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;

procedure a2_backtrack is
	nQueens : constant integer := Integer'Value(Argument(1));
	k, count, temp : integer := 0;
	a : array(0 .. nQueens + 1) of integer;
	fp : file_type;
	filename : String(1 .. 50);
	
	procedure print_solution(nQueens : integer) is
	begin
		count := count + 1;
		new_line(fp);put(fp, Integer'image(count)); put(fp,":");new_line(fp);
		
		for i in 1 .. nQueens loop
			for j in 1 .. nQueens loop
				if(a(i) = j) then
					put(fp,"Q ");
				else
					put(fp,". ");
				end if;
			end loop;
			new_line(fp);
		end loop;
		
	end print_solution;

	function place(pos : integer) return Boolean is
	begin
		for i in 1 .. pos-1 loop
		
			if( (a(i)=a(pos)) or ((abs(a(i)-a(pos))=abs(i-pos))) ) then
				return false;
			end if;
			
		end loop;
		
		return true;
	end place;

begin
	k := k + 1;
	a(k) := 0;
	
	new_line;put("Welcome to the" & Integer'image(nQueens) & "-Queens Solver");new_line;
	put("Please enter the filename to save solutions to: ");
	Get_Line (filename, temp);
	
	create(fp, out_file, filename(1 .. temp));
	
	while (k /= 0) loop
		a(k) := a(k) + 1;
		
		while(a(k) <= nQueens and not place(k)) loop
			a(k) := a(k) + 1;
		end loop;
		
		if (a(k) <= nQueens) then
			
			if (k = nQueens) then
				print_solution(nQueens);
			else
				k := k + 1;
				a(k) := 0;
			end if;
		else
			k := k - 1;
		end if;
		
	end loop;
	put(count);
end a2_backtrack;
