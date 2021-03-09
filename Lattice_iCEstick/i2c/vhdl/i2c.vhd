library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master is
    port(
        clk         : in    std_logic;
        rst_pi      : in    std_logic;
        addr        : in    std_logic_vector(6 downto 0);
        data        : in    std_logic_vector(7 downto 0);
        read_write  : in    std_logic;
        sda         : out   std_logic;
        scl         : out   std_logic
    );
end i2c_master;

architecture rtl of i2c_master is
    signal counter :    natural range 0 to 7 := 6;
    signal full_clk_toggle: std_logic;

    type state is (IDLE, STARTBIT, ADDRESS, READ_WRITE, ADDR_ACKNACK, DATA, DATA_ACKNACK, STOPBIT);
    signal c_st, n_st: state;
begin

    p_seq: process (rst_pi, clk)
    begin
      if rst_pi = '1' then
        c_st <= IDLE;
      elsif rising_edge(clock_1hz) then
        c_st <= n_st;
      end if;
    end process;

    p_com: process (c_st, addr, data, read_write, counter)
    begin   
        n_st <= c_st; -- remain in current state
        case c_st is
            when IDLE =>
                n_st <= STARTBIT;
                counter = 6
            when STARTBIT =>
                n_st <= ADDRESS;
                sda <= '0';
            when ADDRESS =>
                if counter > 0 then
                    sda <= address(counter);
                else
                    sda <= address(counter);
                    counter = 7;
                    n_st <=  READ_WRITE;
                end if ;
            when READ_WRITE =>
                n_st <=  ADDR_ACKNACK;
                sda <= read_write;
            when ADDR_ACKNACK =>
                n_st <=  ADDR_ACKNACK;
                sda <= '0';
            when DATA =>
                if counter > 0 then
                    sda <= data(counter);
                else
                    sda <= data(counter);
                    n_st <=  DATA_ACKNACK;
                end if ;
            when DATA_ACKNACK =>
                sda <= '0';
            when STOPBIT =>
                sda <= '1';
            when others =>
                n_st <= IDLE; -- handle parasitic states
                sda <= '0';
        end case;
    end process;
end rtl;