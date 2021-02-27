library ieee;
use ieee.std_logic_1164.all;

entity clock is
    port(
        clk_pi: in  std_logic;
        clk_1hz: out std_logic
    );
end clock;

architecture rtl of clock is
    constant c_CNT_1HZ   : natural := 12000000;
    signal r_CNT_1HZ   : natural range 0 to c_CNT_1HZ;
    signal r_TOGGLE_1HZ   : std_logic := '0';
begin
    p_clk_1hz : process (clk_pi) is
    begin
        if rising_edge(clk_pi) then
        if r_CNT_1HZ = c_CNT_1HZ-1 then  -- -1, since counter starts at 0
            r_TOGGLE_1HZ <= not r_TOGGLE_1HZ;
            r_CNT_1HZ    <= 0;
        else
            r_CNT_1HZ <= r_CNT_1HZ + 1;
        end if;
        end if;
    end process p_clk_1hz;
    clk_1hz <= r_TOGGLE_1HZ;
end rtl;

