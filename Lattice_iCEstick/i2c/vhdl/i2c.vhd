library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master is
    port(
        clk         : in    std_logic;
        rst_pi      : in    std_logic;
        addr        : in    std_logic_vector(6 downto 0);
        dat         : in    std_logic_vector(7 downto 0);
        rw          : in    std_logic;
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
        counter <= 6;
        sda <= '1';
      elsif rising_edge(clk) then
        case c_st is
            when IDLE =>
                counter <= 6;
                sda <= '1';
                c_st <= STARTBIT;
            when STARTBIT =>
                sda <= '0';
                c_st <= ADDRESS;
            when ADDRESS =>
                if counter = 0 then
                    sda <= addr(counter);
                    counter <= 7;
                    c_st <=  READ_WRITE;  
                else
                    sda <= addr(counter);
                    counter <= counter - 1;
                    c_st <=  ADDRESS; 
                end if ;
            when READ_WRITE =>
                sda <= rw;
                c_st <=  ADDR_ACKNACK;
            when ADDR_ACKNACK =>
                c_st <=  DATA;
                sda <= '0';
            when DATA =>
                if counter = 0 then
                    sda <= dat(counter);
                    c_st <=  DATA_ACKNACK;  
                else
                    sda <= dat(counter);
                    counter <= counter - 1;
                    c_st <=  DATA;
                end if ;
            when DATA_ACKNACK =>
                sda <= '0';
                c_st <=  STOPBIT;
            when STOPBIT =>
                sda <= '1';
                c_st <=  IDLE;
            when others =>
                c_st <= IDLE; -- handle parasitic states
                sda <= '0';
        end case;
      end if;
    end process;
end rtl;