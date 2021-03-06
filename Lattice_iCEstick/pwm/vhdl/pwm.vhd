library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm is
    port(
        clk: in  std_logic;
        rst_pi : in std_logic;
        led_out: out std_logic
    );
end pwm;


architecture rtl of pwm is
    constant duty_cycle     : natural := 8;
    signal pwm_counter      : unsigned(3 downto 0);
    signal pwm_out          : std_logic := '0';
begin
    pwm_p: process(clk, rst_pi)
    begin
        if rst_pi = '1' then
            pwm_counter <= (others => '0');
            pwm_out <= '0';     
        elsif rising_edge(clk) then
            if pwm_counter < duty_cycle then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
            pwm_counter <= pwm_counter + 1;
        end if;
    end process pwm_p;
    led_out <= pwm_out;
end rtl;