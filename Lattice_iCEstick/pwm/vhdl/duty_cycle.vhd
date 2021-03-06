library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity duty_cycle is
    port(
        clk_pi          : in  std_logic;
        rst_pi          : in std_logic;
        duty_cylce_po   : out std_logic_vector(4 downto 0)
    );
end duty_cycle;

architecture rtl of duty_cycle is
    constant c_CNT_100HZ        : natural := 1200000;
    signal r_CNT_100HZ          : natural range 0 to c_CNT_100HZ;
    signal up_down              : integer;
    signal duty_cycle           : unsigned(4 downto 0);
begin
    duty_p: process(clk_pi, rst_pi)
    begin
        if rst_pi = '1' then
            r_CNT_100HZ <= 0;
            duty_cycle <= (others => '0');
            up_down <= 0;   
        elsif rising_edge(clk_pi) then
            if r_CNT_100HZ = c_CNT_100HZ - 1 then
                if up_down = 0 then         
                    duty_cycle <= duty_cycle + 1;
                    if duty_cycle = 15 then
                        up_down <= 1;
                    end if ;
                else
                    if duty_cycle > 0 then
                        duty_cycle <= duty_cycle - 1;
                    else 
                        up_down <= 0;
                    end if ;
                end if;
                r_CNT_100HZ <= 0;
            else
                r_CNT_100HZ <= r_CNT_100HZ + 1;   
            end if;
        end if;
    end process duty_p;
    duty_cylce_po <= std_logic_vector(duty_cycle);
end rtl;