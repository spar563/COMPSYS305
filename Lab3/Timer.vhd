library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer is
	port(
	Data_In :  in std_logic_vector (9 downto 0);
	Clk, start : in std_logic;
	Time_Out : out std_logic;
	SevenSeg_Out : out std_logic_vector (6 downto 0)
	);
end entity;

architecture arc of Timer is
	component BCD_counter
		Port (
       		Clk : in STD_LOGIC;
        	Direction : in STD_LOGIC;
        	Init : in STD_LOGIC;
        	Enable : in STD_LOGIC;
        	Q_Out : out STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;

	component BCD_to_SevenSeg is
     		port (
		BCD_digit : in std_logic_vector(3 downto 0);
           	SevenSeg_out : out std_logic_vector(6 downto 0)
		);
	end component;

	component Clk_1Hz is
		port ( 
		Clk_in : in std_logic;
		Clk_out : out std_logic;
		);
	

	signal Counter_Digit : std_logic_vector (3 downto 0);
	signal Timer_Enable, Counter_Enable : std_logic := '0';
	signal Timer_Direction : std_logic := '1';
	signal Timeout : boolean := false;
begin

	Clk_1Hz : Clk_1Hz
	port map ( 
		Clk_in => Clk
		Clk_out => -- signal for the new clock
	);

	Counter : BCD_counter
	port map (
		Clk => Clk,
        	Direction => Timer_Direction,
        	Init => Data_In(9),
        	Enable => Counter_Enable,
        	Q_Out => Counter_Digit
	);



	SevenSeg : BCD_to_SevenSeg
	port map ( 
		BCD_digit => Counter_Digit,
        	SevenSeg_out => SevenSeg_out
	);


process(Clk, Direction, Reset, Enable)
	begin

end process;

end architecture arc;