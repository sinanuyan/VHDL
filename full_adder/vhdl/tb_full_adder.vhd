library ieee;
use ieee.std_logic_1164.all;

entity tb_fulladder is
end tb_fulladder;

architecture TB of tb_fulladder is

  -- signal declaration
  signal a :std_logic;
  signal b :std_logic;
  signal carry_in :std_logic;
  signal sum :std_logic;
  signal carry_out :std_logic;

begin
  
  -- instantiate the module under test
  -- Note: If library is known, in which component has been compiled into,
  -- instantiation is possible as shown below without component declaration.  
  MUT: entity work.fulladder
    port map(
      a_pi      => a,
      b_pi      => b,
      carry_pi  => carry_in,
      sum_po    => sum,
      carry_po  => carry_out
      );

  ---------------------------------------------------------------------------
  -- stimuli application and automatic check of expected responses
  ---------------------------------------------------------------------------
  process
    -- test procedure (to be called for all combinations of input patterns)
    procedure check_stim (a_test, b_test, carry_in_test, carry_out_expected, sum_expected : in std_logic) is
      variable actual_carry, actual_sum, expected_carry, expected_sum  : std_logic := '0';
      variable check_fail_carry, check_fail_sum       : boolean := true;
    begin
      -- 1st test pattern
      a         <= a_test;
      b         <= b_test;
      carry_in  <= carry_in_test;
      wait for 1ms;
      -- gather actual and expected responses
      actual_carry    := carry_out;
      actual_sum      := sum;
      expected_carry  := carry_out_expected;
      expected_sum    := sum_expected;
      -- compare actual and expected responses
      check_fail_carry := actual_carry /= expected_carry;
      check_fail_sum := actual_sum /= expected_sum;
      -- report result of check
      if check_fail_carry and check_fail_sum then
        report ">> Carry Output ERROR for input pattern: " & std_logic'image(a_test) & " " & std_logic'image(b_test) & " " & std_logic'image(carry_in_test)
          severity error;
      else
        report ">> Input pattern: " & std_logic'image(a_test) & " " & std_logic'image(b_test) & " " & std_logic'image(carry_in_test) & " tested OK."
          severity note;
      end if;
    end procedure;
    
  begin
    -- apply all test patterns
    check_stim('0','0', '0', '0', '0');
    check_stim('0','0', '1', '0', '1');
    check_stim('0','1', '0', '0', '1');
    check_stim('0','1', '1', '1', '0');
    check_stim('1','0', '0', '0', '1');
    check_stim('1','0', '1', '1', '0');
    check_stim('1','1', '0', '1', '0');
    check_stim('1','1', '1', '1', '0');

    report ">> ==== End of Simulation ====" severity note;
    wait;
  end process;
	
end TB;
