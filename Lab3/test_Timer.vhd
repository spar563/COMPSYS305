library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_Timer is
end entity test_Timer;

architecture sim of test_Timer is
  signal Data_in : std_logic_vector (9 downto 0);
  signal Clk, start : std_logic := '0';
  signal Time_Out : std_logic := '0';
  signal SevenSeg_Out_ones, SevenSeg_Out_tens, SevenSeg_Out_mins : std_logic_vector (6 downto 0);

	component Timer is
		port(
	Data_In :  in std_logic_vector (9 downto 0);
	Clk, start : in std_logic;
	Time_Out : out std_logic;
	SevenSeg_Out_ones : out std_logic_vector (6 downto 0);
	SevenSeg_Out_tens : out std_logic_vector (6 downto 0);
	SevenSeg_Out_mins : out std_logic_vector (6 downto 0)
	);
	end component;

begin
  dut: entity work.Timer
    port map (
        Data_in => Data_in,
        Clk => Clk,
        start => start,
	Time_Out => Time_Out,
        SevenSeg_Out_ones => SevenSeg_Out_ones,
        SevenSeg_Out_tens => SevenSeg_Out_tens,
        SevenSeg_Out_mins => SevenSeg_Out_mins
    );

  -- Data_in process
  Data_in_process : process
  begin
    Data_in <= "0100110111";
    wait;  -- Adding wait for some time to prevent infinite loop
   
  end process;
  
  -- Clock process
  Clk_process: process
  begin
    Clk <= '0';
    wait for 5 ns;
    Clk <= '1';
    wait for 5 ns;
  end process;
  
  -- Start process
  Start_process: process
  begin
    start <= '1';
    wait for 10 ns;
    start <= '0';
wait for 2300 ns;
start <= '1';
    wait for 10 ns;
    start <= '0';
    wait;
  end process;
  
end architecture sim;
