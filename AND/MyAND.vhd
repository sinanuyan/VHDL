library ieee;
use ieee.std_logic_1164.all;

entity MyAnd is
  port(
    x_pi : in  std_logic;
    y_pi : in  std_logic;
    z_po : out std_logic
    );
end MyAnd;

architecture rtl of MyAnd is
begin
  z_po <= x_pi and y_pi;
end rtl;
