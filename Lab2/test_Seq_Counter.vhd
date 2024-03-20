entity test_Seq_Counter is
end entity test_Seq_Counter;

architecture my_test of test_Seq_Counter is
	signal t_clk, t_reset, t_enable : bit;
	signal t_mode : bit_vector(1 downto 0);
	signal t_Q : bit_vector(3 downto 0);

	component Seq_Counter is
		port (Clk, Reset, Enable : in bit;
			Mode : in bit_vector(1 downto 0);
			Q : out bit_vector(3 downto 0));
	end component;

	begin
		DUT: Seq_Counter port map (t_clk, t_reset, t_enable, t_mode, t_Q);

		clk: process
		begin
			t_clk <= '0';
			wait for 5 ns;
			t_clk <= '1';
			wait for 5 ns;
		end process clk;

		init: process
		begin
			t_reset <= '1';
			wait for 10 ns;
			t_reset <= '0';
			
			t_enable <= '1';
	
			t_mode <= "00";
			wait for 500 ns;

			t_mode <= "01";
			wait for 500 ns;

			t_mode <= "10";
			wait for 500 ns;

			t_mode <= "11";
			wait for 100 ns;
		end process init;

end architecture my_test;
