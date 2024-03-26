library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_BCD_counter is
end test_BCD_counter;

architecture Behaviour of test_BCD_counter is
    signal Clk, Direction, Init, Enable : std_logic := '0';
    signal Q_Out : std_logic_vector(3 downto 0);

	component BCD_counter is
    		Port (
        		Clk : in STD_LOGIC;
        		Direction : in STD_LOGIC;
        		Init : in STD_LOGIC;
        		Enable : in STD_LOGIC;
        		Q_Out : out STD_LOGIC_VECTOR (3 downto 0)
    		);
	end component;
begin
    dut: entity work.BCD_counter
        port map (
            Clk => Clk,
            Direction => Direction,
            Init => Init,
            Enable => Enable,
            Q_Out => Q_Out
        );

    Clk_process: process
    begin
        Clk <= '0';
        wait for 5 ns;
        Clk <= '1';
        wait for 5 ns;
    end process;

    Stimulus: process
    begin
        Init <= '1';
        Direction <= '0'; -- Up counter
        Enable <= '1';
        wait for 100 ns;
        Init <= '0';
	wait for 100 ns;
	Direction <= '1'; -- down counter
        --wait for 100 ns;
        --Enable <= '0';
        wait;
    end process;
end Behaviour;