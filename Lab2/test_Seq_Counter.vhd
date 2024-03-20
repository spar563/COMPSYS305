library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

entity test_Seq_Counter  is
end entity test_Seq_Counter ;
architecture sim of test_Seq_Counter is
  signal Clk, Reset, Enable : std_logic := '0';
  signal Mode : std_logic_vector(1 downto 0) := "00";
  signal Q : std_logic_vector(3 downto 0);
begin
  dut: entity work.Seq_Counter 
    port map (
      Clk => Clk,
      Reset => Reset,
      Enable => Enable,
      Mode => Mode,
      Q => Q
    );
  -- Clock process
  Clk_process: process
  begin
    Clk <= '0';
    wait for 5 ns;
    Clk <= '1';
    wait for 5 ns;
  end process;
  -- Reset process
  Reset_process: process
  begin
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    wait;
  end process;
  -- Enable Process
  Enable_process : process
  begin
    Enable <= '1';
    wait for 100 ns;
    Enable <= '0';
    wait for 1 ns;
    Enable <= '1';
    wait for 100 ns;
    Enable <= '1';
    wait;
  end process;
  -- Test mode changes
  Mode_process: process
  begin
    Mode <= "00";
    wait for 100 ns;
    Mode <= "01";
    wait for 100 ns;
    Mode <= "10";
    wait for 100 ns;
    Mode <= "11";
    wait;
  end process;
end architecture sim;

