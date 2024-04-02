library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity three_digit_counter is
Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_sec : out STD_LOGIC_VECTOR (7 downto 0);
	Q_min : out std_logic_vector (3 downto 0)
);
end three_digit_counter;

architecture Behaviour of three_digit_counter is

component BCD_counter
Port (
	Data_in : in std_logic_vector;
        Clk : in STD_LOGIC;
        Direction : in STD_LOGIC;
        Init : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_Out : out STD_LOGIC_VECTOR (3 downto 0)
);
end component;

signal ones_place, tens_place, mins_place : std_logic_vector(3 downto 0);
signal tens_enable, mins_enable : std_logic;
signal ones_in, tens_in, mins_in : std_logic_vector(3 downto 0);

begin

BCD_Ones : BCD_counter port map (
			Data_in => ones_in,
			Clk => Clk,
			Direction => '1',
			Init => Reset,
			Enable => Enable,
			Q_Out => ones_place );

BCD_Tens : BCD_counter port map (
			Data_in => tens_in,
			Clk => Clk,
			Direction => '1',
			Init => Reset,
    			Enable => tens_enable,
			Q_Out => tens_place );

BCD_Mins : BCD_counter port map (
			Data_in => mins_in,
			Clk => Clk,
			Direction => '1',
			Init => Reset,
    			Enable => mins_enable,
			Q_Out => mins_place );

ones_in <= "1001";
tens_in <= "0101";
mins_in <= "0011";


tens_enable <= '1' when (ones_place = "0000") and (Enable = '1') else '0';
mins_enable <= '1' when (tens_place = "0000") and (tens_enable = '1') else '0';


Q_sec <= tens_place & ones_place;
Q_min <= mins_place;

end Behaviour;
