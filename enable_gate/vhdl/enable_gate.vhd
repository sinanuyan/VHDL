library ieee;
use ieee.std_logic_1164.all;

entity enable_gate is
  port(
    x_pi    : in  std_logic_vector(3 downto 0);
    enable  : in  std_logic;
    y_po    : out std_logic_vector(3 downto 0)
    );
end enable_gate;

architecture rtl of enable_gate is
begin
  y_po <= x_pi and (enable & enable & enable & enable);
end rtl;
