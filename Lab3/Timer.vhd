library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Timer is
	port(
	Data_In :  in std_logic_vector (9 downto 0);
	Clk, start : in std_logic;
	Time_Out : out std_logic;
	SevenSeg_Out_ones : out std_logic_vector (6 downto 0);
	SevenSeg_Out_tens : out std_logic_vector (6 downto 0);
	SevenSeg_Out_mins : out std_logic_vector (6 downto 0)
	);
end entity;

architecture arc of Timer is

component three_digit_counter
Port (
	Data_in : in std_logic_vector(9 downto 0);
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_sec : out STD_LOGIC_VECTOR (7 downto 0);
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
signal seconds : std_logic_vector(7 downto 0);
signal minutes : std_logic_vector (3 downto 0);
signal value_in : std_logic_vector (3 downto 0);
signal value_out : std_logic_vector(6 downto 0);


begin

timer : three_digit_counter port map(
	Data_in => Data_in,
	Clk => Clk,
	Reset => start,
	Enable => timer_enable,
	Q_sec => seconds,
	Q_min => minutes
);

SevenSeg : BCD_to_SevenSeg port map(
	BCD_digit => value_in,
	SevenSeg_out => value_out
);


timer_enable <= '0' when (seconds = "00000000") and (minutes = "0000") and (start = '0') else '1';

Time_Out <= '1' when (timer_enable = '0') else '0';


end arc;