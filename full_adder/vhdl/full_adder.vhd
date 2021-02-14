library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
  port(
    a_pi      : in  std_logic;
    b_pi      : in  std_logic;
    carry_pi  : in  std_logic;
    sum_po    : out std_logic;
    carry_po  : out std_logic
    );
end FullAdder;

architecture struct of FullAdder is

  component HalfAdder is
    port(
      half_adder_x_pi  : in  std_logic;
      half_adder_y_pi  : in  std_logic;
      half_adder_u_po  : out std_logic;
      half_adder_v_po  : out std_logic
      );
  end component HalfAdder;

  component MyOR is
    port(
      or_x_pi  : in  std_logic;
      or_y_pi  : in  std_logic;
      or_u_po  : out std_logic
      );
  end component MyOR;
  
  signal half_adder_1_xor_out : std_logic;
  signal half_adder_1_and_out : std_logic;
  signal half_adder_2_and_out : std_logic;
	
begin
  HA1 : HalfAdder
    port map(
      half_adder_x_pi => a_pi,
      half_adder_y_pi => b_pi,
      half_adder_u_po => half_adder_1_and_out,
      half_adder_v_po => half_adder_1_xor_out
      );

  HA2 : HalfAdder
  port map(
    half_adder_x_pi => half_adder_1_xor_out,
    half_adder_y_pi => carry_pi,
    half_adder_u_po => half_adder_2_and_out,
    half_adder_v_po => sum_po
    );
  
  OR1 : MyOr
    port map(
      or_x_pi => half_adder_1_and_out,
      or_y_pi => half_adder_1_xor_out,
      or_u_po => carry_po
      );
end struct;