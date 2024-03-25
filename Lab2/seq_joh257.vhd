
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity seq_counter is
port (Clk, Reset, Enable : in std_logic;
	Mode : in std_logic_vector(1 downto 0);
	Q : out std_logic_vector(3 downto 0));
end entity seq_counter;

architecture behaviour of seq_counter is
begin
    process (Clk, Reset)
        variable v_Q: std_logic_vector(3 downto 0);
        variable current: std_logic_vector(1 downto 0);
    begin
        if (Reset = '1') then
            v_Q := "0000";
		case Mode is
			when "00" =>
              		 v_Q:="1011";
            		when "01" =>
              		  v_Q := "1010";
            		when "10" =>
                	  v_Q := "0001";
            		 when others =>
              		  v_Q := "1111";
          	end case;
        elsif (rising_edge(Clk)) then
            if (Enable = '1') then
                if (Mode = "00") then
                    if (Mode = current) then
			if (v_Q = "0001") then
				v_Q := "1011";
			else
			 v_Q := v_Q - "0010";
			end if;                     
                    else
                        v_Q := "1011";
                    end if;
                elsif (Mode = "01") then
                        case v_Q is
                            when "1010" => v_Q := "0101";
                            when "0101" => v_Q := "1000";
                            when "1000" => v_Q := "0011";
                            when "0011" => v_Q := "0111";
                            when "0111" => v_Q := "0110";
                            when "0110" => v_Q := "1100";
                            when "1100" => v_Q := "1010";
			    when others => v_Q := "1010";
                        end case;
                elsif (Mode = "10") then
                    if (Mode = current) then
                        v_Q := v_Q + "0001";
                    else
                        v_Q := "0001";
                    end if;
                elsif (Mode = "11") then
                    v_Q := "1111";
                end if;
                current := Mode;
            end if;
        end if;
        Q <= v_Q;
    end process;
end architecture behaviour;
