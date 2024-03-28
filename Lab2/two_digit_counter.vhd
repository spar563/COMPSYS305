library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity two_digit_counter is
Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR (7 downto 0)
);
end two_digit_counter;

architecture Behaviour of two_digit_counter is

component BCD_counter
Port (
        Clk : in STD_LOGIC;
        Direction : in STD_LOGIC;
        Init : in STD_LOGIC;
        Enable : in STD_LOGIC;
        Q_Out : out STD_LOGIC_VECTOR (3 downto 0)
);
end component;

signal ones_place, tens_place : std_logic_vector(3 downto 0);
signal tens_enable : std_logic;

begin

BCD_Ones : BCD_counter port map (
			Clk => Clk,
			Direction => '1',
			Init => Reset,
			Enable => Enable,
			Q_Out => ones_place );

BCD_Tens : BCD_counter port map (
			Clk => Clk,
			Direction => '1',
			Init => Reset,
    			Enable => tens_enable,
			Q_Out => tens_place );


tens_enable <= '1' when (ones_place = "0000") and (Enable = '1') else '0';



Q <= tens_place & ones_place;

end Behaviour;

