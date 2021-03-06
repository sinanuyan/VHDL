library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm is
    port(
        clk_pi: in  std_logic;
        rst_pi : in std_logic;
        led_out: out std_logic_vector(4 downto 0)
    );
end pwm;

architecture rtl of pwm is
    component duty_cycle is
        port(
            clk_pi          : in  std_logic;
            rst_pi          : in std_logic;
            duty_cylce_po   : out std_logic_vector(4 downto 0)
            );
    end component duty_cycle;

    signal dc               : std_logic_vector(4 downto 0);
    signal pwm_counter      : unsigned(3 downto 0);
    signal pwm_out          : std_logic := '0';
begin
    DutyCycle : duty_cycle
        port map(
            clk_pi => clk_pi,
            rst_pi => rst_pi,
            duty_cylce_po => dc
        );

    pwm_p: process(clk_pi, rst_pi)
    begin
        if rst_pi = '1' then
            pwm_counter <= (others => '0');
            pwm_out <= '0';     
        elsif rising_edge(clk_pi) then
            if pwm_counter < unsigned(dc) then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
            pwm_counter <= pwm_counter + 1;
        end if;
    end process pwm_p;

    led_out <= (pwm_out & pwm_out & pwm_out & pwm_out & pwm_out);
end rtl;