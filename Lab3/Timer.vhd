library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Timer is
	port(
	SW :  in std_logic_vector (9 downto 0);
	CLOCK_50 : in std_logic; 
	KEY : in std_logic_vector(3 downto 0);
	LEDR : out std_logic_vector(9 downto 0);
	HEX0 : out std_logic_vector (6 downto 0);
	HEX1 : out std_logic_vector (6 downto 0);
	HEX2 : out std_logic_vector (6 downto 0)
	);
end entity;

architecture arc of Timer is

component clock is
port (
		clk_50MHz : in  STD_LOGIC;
        clk_1Hz   : out STD_LOGIC 
);
end component;

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

component BCD_to_SevenSeg
port (
	BCD_digit : in std_logic_vector(3 downto 0);
        SevenSeg_out : out std_logic_vector(6 downto 0)
);
end component;


signal timer_enable : std_logic;
signal ones_place, tens_place, mins_place : std_logic_vector(3 downto 0);
signal value_in : std_logic_vector (3 downto 0);
signal clock_1Hz : std_logic;
signal reset : std_logic;

begin

newClock : clock port map(
	clk_50MHz => CLOCK_50,
   clk_1Hz => clock_1Hz
	);
		  
timer : three_digit_counter port map(
	Data_in => SW,
	Clk => clock_1Hz,
	Reset => reset,
	Enable => timer_enable,
	Q_sec_ones => ones_place,
	Q_sec_tens => tens_place,
	Q_min => mins_place
);

SevenSeg_Ones : BCD_to_SevenSeg port map(
	BCD_digit => ones_place,
	SevenSeg_out => HEX0
);

SevenSeg_Tens : BCD_to_SevenSeg port map(
	BCD_digit => tens_place,
	SevenSeg_out => HEX1
);

SevenSeg_Mins : BCD_to_SevenSeg port map(
	BCD_digit => mins_place,
	SevenSeg_out => HEX2
);


reset <= '1' when (key(0) = '0') else '0'; 


timer_enable <= '0' when (ones_place = "0000") and (tens_place = "0000") and (mins_place = "0000") and (KEY(0) = '1') else '1';

LEDR(0) <= '1' when (ones_place = "0000") and (tens_place = "0000") and (mins_place = "0000") and (KEY(0) = '1') else '0';



end arc;