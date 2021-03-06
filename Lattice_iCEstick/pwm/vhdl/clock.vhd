library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
    port(
        clk_pi:     in  std_logic;
        clk_1hz:    out std_logic;
        clk_10hz:   out std_logic;
        clk_100hz:  out std_logic;
        clk_1000hz: out std_logic
    );
end clock;

architecture rtl of clock is
    constant c_CNT_1HZ      : natural := 6000000;
    constant c_CNT_10HZ     : natural := 600000;
    constant c_CNT_100HZ    : natural := 60000;
    constant c_CNT_1000HZ   : natural := 6000;
    signal r_CNT_1HZ        : natural range 0 to c_CNT_1HZ;
    signal r_CNT_10HZ       : natural range 0 to c_CNT_10HZ;
    signal r_CNT_100HZ      : natural range 0 to c_CNT_100HZ;
    signal r_CNT_1000HZ     : natural range 0 to c_CNT_1000HZ;
    signal r_TOGGLE_1HZ     : std_logic := '0';
    signal r_TOGGLE_10HZ    : std_logic := '0';
    signal r_TOGGLE_100HZ   : std_logic := '0';
    signal r_TOGGLE_1000HZ  : std_logic := '0';
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

    p_clk_10hz : process (clk_pi) is
    begin
        if rising_edge(clk_pi) then
            if r_CNT_10Z = c_CNT_10HZ-1 then  -- -1, since counter starts at 0
                r_TOGGLE_10HZ <= not r_TOGGLE_10HZ;
                r_CNT_10HZ    <= 0;
            else 
                r_CNT_10HZ <= r_CNT_10HZ + 1;
            end if;
        end if;
    end process p_clk_10hz;
    clk_10hz <= r_TOGGLE_10HZ;

    p_clk_100hz : process (clk_pi) is
    begin
        if rising_edge(clk_pi) then
            if r_CNT_100HZ = c_CNT_100HZ-1 then  -- -1, since counter starts at 0
                r_TOGGLE_100HZ <= not r_TOGGLE_100HZ;
                r_CNT_100HZ    <= 0;
            else 
                r_CNT_100HZ <= r_CNT_100HZ + 1;
            end if;
        end if;
    end process p_clk_100hz;
    clk_100hz <= r_TOGGLE_100HZ;

    p_clk_1000hz : process (clk_pi) is
        begin
            if rising_edge(clk_pi) then
                if r_CNT_1000HZ = c_CNT_1000HZ-1 then  -- -1, since counter starts at 0
                    r_TOGGLE_1000HZ <= not r_TOGGLE_1000HZ;
                    r_CNT_1000HZ    <= 0;
                else 
                    r_CNT_1000HZ <= r_CNT_1000HZ + 1;
                end if;
            end if;
        end process p_clk_1000hz;
        clk_1000hz <= r_TOGGLE_1000HZ;
end rtl;

