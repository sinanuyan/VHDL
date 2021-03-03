library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity led_rotate is
    port(
        clk: in  std_logic;
        rst_pi : in std_logic;
        led_out: out std_logic_vector(3 downto 0)
    );
end led_rotate;


architecture rtl of led_rotate is
    component clock is
        port(
            clk_pi: in  std_logic;
            clk_1hz: out std_logic
          );
    end component clock;
    signal clock_1hz    : std_logic;
    type state is (S0, S1, S2, S3);
    signal c_st, n_st: state;
begin
    CLK_1HZ : clock
    port map(
      clk_pi => clk,
      clk_1hz => clock_1hz
      );
    
    p_seq: process (rst_pi, clock_1hz)
    begin
      if rst_pi = '1' then
      c_st <= S0;
      elsif rising_edge(clock_1hz) then
      c_st <= n_st;
      end if;
    end process;

    p_com: process (c_st)
    begin
        n_st <= c_st; -- remain in current state
        case c_st is
            when S0 =>
                n_st <= S1;
                led_out <= "0001";
            when S1 =>
                n_st <= S2;
                led_out <= "0010";
            when S2 =>
                n_st <= S3;
                led_out <= "0100";
            when S3 =>
                n_st <= S0;
                led_out <= "1000";
            when others =>
                n_st <= S0; -- handle parasitic states
                led_out <= "0001";
        end case;
    end process;
end rtl;