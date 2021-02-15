library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic(
    N : integer := 4
  );
  port(
    clock_in  : in  std_logic;
    reset_in  : in  std_logic;
    count_out : out std_logic_vector(N-1 downto 0);
    flag_out  : out std_logic
    );
end counter;

architecture rtl of counter is
  signal count  : unsigned(N-1 downto 0);
begin
  process (clock_in, reset_in) begin
         if (reset_in = '1') then
            count <= (others=>'0');
            flag_out <= '0';
         elsif (rising_edge(clock_in)) then
            if count = to_unsigned(N,N) then
              count <= (others=>'0');
              flag_out <= '1';
            else
              count <= count + 1;
              flag_out <= '0';
            end if;
         end if;
  end process;
end rtl;
