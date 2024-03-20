library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mode_Select_Counter is
 port ( Clk: in STD_LOGIC;
        Reset: in STD_LOGIC;
        Enable: in STD_LOGIC;
        Mode: in STD_LOGIC_Vector(1 downto 0);
        Q: out STD_LOGIC_VECTOR (3 downto 0));
end Mode_Select_Counter;

architecture Behavioral of Mode_Select_Counter is
    signal Counter : integer range 0 to 15 := 0;
    signal PreviousMode : std_logic_vector(1 downto 0);
begin
    process (Clk, Reset)
    begin
        if Reset = '1' then
  		Counter <= 0;
                PreviousMode <= "00";
	elsif rising_edge(Clk) then          
            if Enable = '1' then
                case Mode is
                    when "00" =>
			if Mode = PreviousMode then
                     	   if Counter = 1 then
	         	           Counter <= 11;
          	               else 
  	                          Counter <= Counter - 2;
        	               end if;
			end if;
                    when "01" =>
                        case Counter is
                            when 10 =>
                                Counter <= 5;
                            when 5 =>
                                Counter <= 8;
                            when 8 =>
                                Counter <= 3;
                            when 3 =>
                                Counter <= 7;
                            when 7 =>
                                Counter <= 6;
                            when 6 =>
                                Counter <= 12;
                            when 12 =>
                                Counter <= 10;
                            when others =>
                                Counter <= 10;
                        end case;
                    when "10" =>
                        if Counter = 13 then
                            Counter <= 1;
                        else
                            Counter <= Counter + 1;
                        end if;
                    when others =>
                        Counter <= 15; -- Mode "11"
                end case;
		--Mode <= PreviousMode;
            end if;
        end if;
    end process;

--    process (Clk)
--    begin
--        if rising_edge(Clk) then
--            Counter <= NextCounter;
--        end if;
--    end process;
--    process (Clk)
--    begin
--        if rising_edge(Clk) then
--            Counter <= NextCounter;
--        end if;
--    end processs;
--    Q <= std_logic_vector(to_unsigned(Counter, Q'length)) when rising_edge(Clk) and Enable = '1' else
--    std_logic_vector(to_unsigned(NextCounter, Q'length));
end Behavioral;

