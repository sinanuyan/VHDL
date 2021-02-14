library ieee;
use ieee.std_logic_1164.all;

entity MyOR is
  port(
    or_x_pi  : in  std_logic;
    or_y_pi  : in  std_logic;
    or_u_po  : out std_logic
    );
end MyOR;

architecture rtl of MyOR is
begin
  or_u_po <= or_x_pi or or_y_pi;
end rtl;
