library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_rotate is
    port(
        clk: in  std_logic;
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
    signal led          : unsigned(3 downto 0); 
begin
    CLK_1HZ : clock
    port map(
      clk_pi => clk,
      clk_1hz => clock_1hz
      );


    process (clock_1hz) is
    begin
        if rising_edge(clock_1hz) then
            led <= (others => '0');
        else
            led <= (others => '1');
        end if;
    end process;
    led_out <= std_logic_vector(led);
end rtl;

