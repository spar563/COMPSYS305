library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_three_digit_counter is
end entity test_three_digit_counter;

architecture sim of test_three_digit_counter is
  signal Data_in : std_logic_vector (9 downto 0);
  signal Clk, Reset, Enable : std_logic := '0';
  signal t_Q_secs : std_logic_vector(3 downto 0);
  signal t_Q_tens : std_logic_vector(3 downto 0);
  signal t_Q_min : std_logic_vector (3 downto 0);

 component three_digit_counter is 
	Port (
	Data_in : in std_logic_vector(9 downto 0);
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_sec_ones : out STD_LOGIC_VECTOR (3 downto 0);
	Q_sec_tens : out STD_LOGIC_VECTOR (3 downto 0);
	Q_min : out std_logic_vector (3 downto 0)
);
end component;

begin
  dut : three_digit_counter port map (
      Data_in => Data_in,
      Clk => Clk,
      Reset => Reset,
      Enable => Enable,
      Q_sec_ones => t_Q_secs,
      Q_sec_tens => t_Q_tens,
      Q_min => t_Q_min
    );

  -- Data_in process
  Data_in_process : process
  begin
    Data_in <= "1100110011";
    wait;
  end process;
  
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