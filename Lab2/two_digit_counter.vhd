library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity two_digit_counter is
	Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (7 downto 0)
	);
end two_digit_counter;

architecture Behaviour of two_digit_counter is
    signal cntr : integer range 00 to 99 := 0;
begin
	process (Clk, Reset)
	begin
		if Reset = '1' then
			cntr <= 99;
		else

		if rising_edge (clk) then
			if Enable = '1' then
				if cntr > 0 then
					-- up counter
					cntr <= cntr - 1;
				else 
					-- set counter to 0 once it reaches 9
					cntr <= 99;
				end if;
			end if;
		end if;

	end if;
	end process;
    Q <= conv_std_logic_vector(cntr, Q'length);
end Behaviour;
	