library ieee;
use ieee.std_logic_1164.all;

entity tb_MyNand is
end tb_MyNand;

architecture TB of tb_MyNand is

  -- signal declaration
  signal u, v, w :std_logic;

begin
  
  -- instantiate the module under test
  -- Note: If library is known, in which component has been compiled into,
  -- instantiation is possible as shown below without component declaration.  
  MUT: entity work.MyNand
    port map(
      u_pi => u,
      v_pi => v,
      w_po => w
      );

  ---------------------------------------------------------------------------
  -- stimuli application and automatic check of expected responses
  ---------------------------------------------------------------------------
  process
    -- test procedure (to be called for all combinations of input patterns)
    procedure check_stim (in1, in2 : in std_logic) is
      variable actual, expected : std_logic := '0';
      variable check_fail       : boolean := true;
    begin
      -- 1st test pattern
      u  <= in1; v  <= in2;
      wait for 1ms;
      -- gather actual and expected responses
      actual   := w;
      expected := not(u and v);
      -- compare actual and expected responses
      check_fail := actual /= expected;
      -- report result of check
      if check_fail then
        report ">> ERROR for input pattern: " & std_logic'image(in1) & " " & std_logic'image(in2)
          severity error;
      else
        report ">> Input pattern: " & std_logic'image(in1) & " " & std_logic'image(in2) & " tested OK."
          severity note;
      end if;
    end procedure;
    
  begin
    -- apply all test patterns
    check_stim('0','0');
    check_stim('0','1');
    check_stim('1','0');
    check_stim('1','1');
 
    report ">> ==== End of Simulation ====" severity note;
    wait;
  end process;
	
end TB;
