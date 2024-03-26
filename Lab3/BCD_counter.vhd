library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity BCD_counter is
	Port (
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
					cntr <= 9;
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
						cntr <= 9;
					end if;
				end if;
			end if;
		end if;
	end if;
	end process;
    Q_Out <= conv_std_logic_vector(cntr, Q_Out'length);
end Behaviour;
	