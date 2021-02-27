library ieee;
use ieee.std_logic_1164.all;

entity HalfAdder is
  port(
    half_adder_x_pi  : in  std_logic;
    half_adder_y_pi  : in  std_logic;
    half_adder_u_po  : out std_logic;
    half_adder_v_po  : out std_logic
    );
end HalfAdder;

architecture rtl of HalfAdder is
begin
  half_adder_u_po <= half_adder_x_pi and half_adder_y_pi;
  half_adder_v_po <= half_adder_x_pi xor half_adder_y_pi;
end rtl;
