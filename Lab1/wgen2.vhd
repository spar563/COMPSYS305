entity wgen2 is
	port (X : in bit_vector(2 downto 0);
	A, B, C : out bit;
	Enable : in bit;
	Z : out bit);
end entity wgen2;

architecture behaviour of wgen2 is
	signal A1, B1, C1, Z1 : bit;
begin
	process
	begin
		A1 <= '1', '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
		B1 <= '0', '1' after 1 ns, '0' after 2 ns, '1' after 3 ns, '0' after 4 ns;
		C1 <= '1', '0' after 1 ns, '1' after 2 ns, '0' after 3 ns, '1' after 4 ns;
		wait for 5 ns;
	end process;

	process(X, A1,B1,C1, Enable)
	begin
		case X is
		when "000" => Z1 <= A1 or B1;
		when "001" => Z1 <= B1 and C1;
		when "010" => Z1 <= A1 or B1 or C1;
		when "011" => Z1 <= (A1 and B1) or C1;
		when "100" => Z1 <= '0';
		when "101" => Z1 <= A1;
		when "110" => Z1 <= B1;
		when "111" => Z1 <= '1';
		end case;
	end process;

A <= A1 when Enable = '1' else '0';
B <= B1 when Enable = '1' else '0';
C <= C1 when Enable = '1' else '0';
Z <= Z1 when Enable = '1' else '0';

end architecture behaviour;