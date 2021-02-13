library ieee;
use ieee.std_logic_1164.all;

entity MyNand is
  port(
    u_pi : in  std_logic;
    v_pi : in  std_logic;
    w_po : out std_logic
    );
end MyNand;

architecture struct of MyNand is

  component MyAnd is
    port(
      x_pi : in  std_logic;
      y_pi : in  std_logic;
      z_po : out std_logic
      );
  end component MyAnd; 
	
  component MyInv is
    port(
      x_pi : in  std_logic;
      z_po : out std_logic
      );
  end component MyInv;
	
  signal tmp : std_logic;

begin

  A1 : MyAnd
    port map(
      x_pi => u_pi,
      y_pi => v_pi,
      z_po => tmp
      );
  
  I1 : MyInv
    port map(
      x_pi => tmp,
      z_po => w_po
      );
  
end struct;

