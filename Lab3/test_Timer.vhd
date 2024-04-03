library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_Timer is
end entity test_Timer;

architecture sim of test_Timer is
  signal Data_in :  in std_logic_vector (9 downto 0);
  signal Clk, start : in std_logic := '0';
  signal Time_Out : out std_logic : '0';
  signal SevenSeg_Out_ones, SevenSeg_Out_tens, SevenSeg_Out_mins : out std_logic_vector (6 downto 0);
begin
  dut: entity work.Timer
    port map (
        Data_in => Data_in,
        Clk => Clk,
        start => start,
        SevenSeg_Out_ones => SevenSeg_Out_ones,
        SevenSeg_Out_tens => SevenSeg_Out_tens,
        SevenSeg_Out_mins => SevenSeg_Out_mins
    );

  -- Data_in process
  Data_in_process : process
  begin
    Data_in <= "1100111001";
    wait for 10 ns;  -- Adding wait for some time to prevent infinite loop
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
    wait;
  end process;
  
end architecture sim;
