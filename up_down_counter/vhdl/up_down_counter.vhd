library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter is
  port(
    clk_pi      : in std_logic;
    rst_pi      : in  std_logic;       
    up_down_pi  : in  std_logic;
    out_po      : out std_logic_vector(7 downto 0)
    );
end up_down_counter;

architecture rtl of up_down_counter is
  signal counter  : unsigned(7 downto 0);
begin
  process(rst_pi, clk_pi)
  begin
    if rst_pi = '1' then
      counter <= (others => '0');
    elsif rising_edge(clk_pi) then
      if up_down_pi = '1' then
        counter <= counter + 1;
      else
        counter <= counter - 1;       
      end if ;
    end if;
  end process;
  out_po <= std_logic_vector(counter);
end rtl;