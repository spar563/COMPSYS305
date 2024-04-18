library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock is
    Port (
        clk_50MHz : in  STD_LOGIC; -- 50 MHz input clock from FPGA board
        clk_1Hz   : out STD_LOGIC  -- 1 Hz output clock for timer
    );
end clock;

architecture Behavioral of clock is
    signal counter : unsigned(24 downto 0); -- 25-bit counter to divide the frequency
	 signal newclock : STD_LOGIC;
begin
    process(clk_50MHz)
    begin
        if rising_edge(clk_50MHz) then
            if counter = 25_000_000 then -- 50 MHz / 25,000,000 = 1 Hz
                newclock <= not newclock; -- Toggle the output clock every 25,000,000 cycles
                counter <= (others => '0'); -- Reset the counter
            else
                counter <= counter + 1; -- Increment the counter
            end if;
        end if;
    end process;
	 
	 clk_1Hz <= newclock;
end Behavioral;
