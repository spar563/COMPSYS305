library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BCD_counter is
	Port (
	Data_in : in std_logic_vector(3 downto 0);
        Clk : in STD_LOGIC;
        Direction : in STD_LOGIC;
        Init : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_Out : out STD_LOGIC_VECTOR (3 downto 0)
	);
end BCD_counter;

architecture Behaviour of BCD_counter is
    signal cntr : integer range 0 to 9 := 0;
begin
	process (Clk)
	begin
	if rising_edge (clk) then
		if Enable = '1' then
			if Init = '1' then
				if Direction = '0' then 
					-- initialise to 0
					cntr <= 0;
				else 
					-- initialise to 9
					cntr <= to_integer(unsigned(Data_in));
				end if;
			else 
				if Direction = '0' then 
 					if cntr < 9 then
						-- up counter
						cntr <= cntr + 1;
					else 
						-- set counter to 0 once it reaches 9
						cntr <= 0;
					end if;
				else
					if cntr > 0 then
						-- up counter
						cntr <= cntr - 1;
					else 
						-- set counter to 0 once it reaches 9
						cntr <= to_integer(unsigned(Data_in));
					end if;
				end if;
			end if;
		end if;
	end if;
	end process;
    Q_Out <= std_logic_vector(to_unsigned(cntr, Q_Out'length));
end Behaviour;
	