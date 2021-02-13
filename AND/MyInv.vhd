library ieee;
use ieee.std_logic_1164.all;

entity MyInv is
  port(
    x_pi : in  std_logic;
    z_po : out std_logic
    );
end MyInv;

architecture rtl of MyInv is
  
begin
  
  z_po <= not x_pi;
  
end rtl;