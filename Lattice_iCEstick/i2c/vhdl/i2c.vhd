library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master is
    port(
        clk         : in    std_logic;
        rst_pi      : in    std_logic;
        full_clk    : out   std_logic;
        half_clk    : out   std_logic
    );
end i2c_master;

architecture rtl of i2c_master is
    signal clk_counter :    unsigned(2 downto 0);
begin
    process (clk_pi, rst_pi) is
    begin
        if rst_pi = '1' then
            full_clk <= '0';
            half_clk <= '0';
        elsif rising_edge(clk_pi) then
            case clk_counter is
                when 0  =>
                    full_clk <= '0';
                    half_clk <= '0';
                    clk_counter <= clk_counter + 1;
                when 1  =>
                    full_clk <= '0';
                    half_clk <= '1';
                    clk_counter <= clk_counter + 1;
                when 2  =>
                    full_clk <= '1';
                    half_clk <= '1';
                    clk_counter <= clk_counter + 1;
                when 3  =>
                    full_clk <= '1';
                    half_clk <= '1';
                    clk_counter <= clk_counter + 1;
                when 4  =>
                    full_clk <= '0';
                    half_clk <= '1';
                    clk_counter <= clk_counter + 1;
                when 5  =>
                    full_clk <= '0';
                    half_clk <= '0';
                    clk_counter <= 0;
                when others =>
                    full_clk <= '0';
                    half_clk <= '0';
                    clk_counter <= 0;
                end case;
        end if;
    end process;
end rtl;