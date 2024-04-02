library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_three_digit_counter is
end entity test_three_digit_counter;

architecture sim of test_three_digit_counter is
  signal Clk, Reset, Enable : std_logic := '0';
  signal t_Q : std_logic_vector(7 downto 0);
  signal t_Q_min : std_logic_vector (3 downto 0);
begin
  dut: entity work.three_digit_counter
    port map (
      Clk => Clk,
      Reset => Reset,
      Enable => Enable,
      Q_sec => t_Q,
      Q_min => t_Q_min
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
    wait for 100 ns;
    Enable <= '1';
    wait for 100 ns;
    Enable <= '1';
    wait;
  end process;
end architecture sim;