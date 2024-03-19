entity Seq_Counter is
	port (Clk : in bit; 
		Reset : in bit;
		Mode : in bit_vector(1 downto 0); 
		Enable : in bit;
		Q : out bit_vector(3 downto 0));
end entity;

architecture arc1 of Seq_Counter is
begin
	process(Clk, Reset)
		variable cntr : integer;
	begin
		if(Reset = '1') then
			cntr := 0;
		end if;
		if(Clk'event and Clk='0') then
			if(Enable = '1') then
				case Mode is
					when "00" =>
						if cntr = 1 then
							cntr := 11;
						else
							cntr := cntr - 2;
						end if;
						case cntr is
							when 1 => Q <= "0001";
							when 2 => Q <= "0010";
							when 3 => Q <= "0011";
							when 4 => Q <= "0100";
							when 5 => Q <= "0101";
							when 6 => Q <= "0110";
							when 7 => Q <= "0111";
							when 8 => Q <= "1000";
							when 9 => Q <= "1001";
							when 10 => Q <= "1010";
							when 11 => Q <= "1011";
							when 12 => Q <= "1100";
							when 13 => Q <= "1101";
							when others => Q <= "0001";
						end case;
					when "01" =>
						case cntr is
							when 10 => cntr := 5;
							when 5 => cntr := 8;
							when 8 => cntr := 3;
							when 3 => cntr := 7;
							when 7 => cntr := 6;
							when 6 => cntr := 12;
							when others => cntr := 10;
						end case;
						case cntr is
							when 1 => Q <= "0001";
							when 2 => Q <= "0010";
							when 3 => Q <= "0011";
							when 4 => Q <= "0100";
							when 5 => Q <= "0101";
							when 6 => Q <= "0110";
							when 7 => Q <= "0111";
							when 8 => Q <= "1000";
							when 9 => Q <= "1001";
							when 10 => Q <= "1010";
							when 11 => Q <= "1011";
							when 12 => Q <= "1100";
							when 13 => Q <= "1101";
							when others => Q <= "0001";
						end case;
					when "10" =>
						if(cntr = 13) then 
							cntr := 1;
						else
							cntr := cntr + 1;
						end if;
						case cntr is
							when 1 => Q <= "0001";
							when 2 => Q <= "0010";
							when 3 => Q <= "0011";
							when 4 => Q <= "0100";
							when 5 => Q <= "0101";
							when 6 => Q <= "0110";
							when 7 => Q <= "0111";
							when 8 => Q <= "1000";
							when 9 => Q <= "1001";
							when 10 => Q <= "1010";
							when 11 => Q <= "1011";
							when 12 => Q <= "1100";
							when 13 => Q <= "1101";
							when others => Q <= "0001";
						end case;
					when "11" =>
						Q <= "1111";
				end case;
			end if;
		end if;
	end process;
end architecture arc1;