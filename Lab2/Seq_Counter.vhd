library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Seq_Counter is
  port (
    Clk, Reset, Enable : in  std_logic;
    Mode : in std_logic_vector(1 downto 0);
    Q : out std_logic_vector(3 downto 0)
  );
end entity Seq_Counter;
architecture behaviour of Seq_Counter is
  signal counter_value : integer range 0 to 15 := 0;
  signal prev_mode : std_logic_vector(1 downto 0) := "00";
begin
  process (Clk, Reset)
  begin
    if Reset = '1' then
counter_value <= 0;
      case Mode is
            when "00" =>
              counter_value <= 11;
            when "01" =>
              counter_value <= 10;
            when "10" =>
              counter_value <= 1;
            when others =>
              counter_value <= 15;
          end case;
    elsif rising_edge(Clk) then
      if Enable = '1' then
        if Mode /= prev_mode then
          case Mode is
            when "00" =>
              counter_value <= 11;
            when "01" =>
              counter_value <= 10;
            when "10" =>
              counter_value <= 1;
            when others =>
              counter_value <= 15;
          end case;
          prev_mode <= Mode;
        else
          case Mode is
            when "00" =>
              if counter_value > 1 then
                counter_value <= counter_value - 2;
              else
                counter_value <= 11;
              end if;
            when "01" =>
              case counter_value is
                when 10 =>
                  counter_value <= 5;
                when 5 =>
                  counter_value <= 8;
                when 8 =>
                  counter_value <= 3;
                when 3 =>
                  counter_value <= 7;
                when 7 =>
                  counter_value <= 6;
                when 6 =>
                  counter_value <= 12;
                when others =>
                  counter_value <= 10;
              end case;
            when "10" =>
              if counter_value < 13 then
                counter_value <= counter_value + 1;
              else
                counter_value <= 1;
              end if;
            when others =>
              null; -- Mode "11", Q is always "1111"
          end case;
        end if;
      end if;
    end if;
  end process;
Q <= conv_std_logic_vector(counter_value, 4);
end architecture behaviour;
