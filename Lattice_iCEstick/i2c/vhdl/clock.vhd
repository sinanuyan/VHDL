library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
    port(
        clk_pi: in  std_logic;
        clk_uart: out std_logic
    );
end clock;

architecture rtl of clock is
    constant c_CNT_UART      : natural := 648;
    signal r_CNT_UART        : natural range 0 to c_CNT_UART;
    signal r_TOGGLE_CLK     : std_logic := '0';
begin
    p_clk_uart : process (clk_pi) is
    begin
        if rising_edge(clk_pi) then
            if r_CNT_UART = c_CNT_UART-1 then  -- -1, since counter starts at 0
                r_TOGGLE_CLK <= not r_TOGGLE_CLK;
                r_CNT_UART    <= 0;
            else
                r_CNT_UART <= r_CNT_UART + 1;
            end if;
        end if;
    end process p_clk_uart;
    clk_uart <= r_TOGGLE_CLK;
end rtl;

