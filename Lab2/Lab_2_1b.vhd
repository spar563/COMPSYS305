entytiy Mode_Select_Counter_Testbench is
end Mode_Select_Counter_Testbench;

architecture Behavioural  Mode_Select_Counter_Testbench is
 constant CLOCK_PERIOD : time := 10ns;
 signal Clk, Reset, Enable : StD_LOGIC := '0';
 signal Mode : STD_LOGIC_VECTOR(1 downto 0) := "00";
 signal Q : STD_LOGIC_VECTOR(3 downto 0);
begin
 DUT : entity work MODE_SELECT_COUNTER
  port map (Clk => Clk, Reset => Reset, Enable => Enable, Mode => Mode, Q => Q)
Clock_Process : process
    begin
        while now < 1000 ns loop
            Clk <= '0';
            wait for CLOCK_PERIOD / 2;
            Clk <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    Stimulus_Process : process
    begin
        Reset <= '1';
        Enable <= '0';
        wait for 50 ns;
        Reset <= '0';
        wait for 200 ns;
        Enable <= '1';
        wait for 400 ns;
        Mode <= "01";
        wait for 500 ns;
        Mode <= "10";
        wait for 500 ns;
        Mode <= "11";
        wait for 500 ns;
        Mode <= "00";
        wait for 500 ns;
        wait;
    end process;
end Behavioural;
                                 