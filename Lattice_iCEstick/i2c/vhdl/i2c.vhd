library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master is
    port(
        clk_pi      : in    std_logic;
        rst_pi      : in    std_logic;
        addr_pi     : in    std_logic_vector(6 downto 0);
        dat_pi      : in    std_logic_vector(7 downto 0);
        rw_pi       : in    std_logic;
        sda_po      : out   std_logic;
        scl_po      : out   std_logic
    );
end i2c_master;

architecture rtl of i2c_master is
    signal counter      :   natural range 0 to 7 := 6;
    signal sda_counter  :   natural range 0 to 3;
    signal scl_counter  :   natural range 0 to 3;
    signal sda_clk      :   std_logic := '0';
    signal scl_clk      :   std_logic := '0';
    signal full_clk_toggle: std_logic;

    type state is (IDLE, STARTBIT, ADDRESS, READ_WRITE, ADDR_ACKNACK, DATA, DATA_ACKNACK, STOPBIT);
    signal c_st, n_st: state;
begin
    process(rst_pi, clk_pi)
    begin
        if rst_pi = '1' then
            sda_counter <= 0;
            sda_clk <= '0';
        elsif rising_edge(clk_pi) then
            if sda_counter = 2 then
                sda_clk <= not sda_clk;
                sda_counter <= 0;
            else
                sda_counter <= sda_counter + 1;         
            end if;
        end if;
    end process;

    process(rst_pi, clk_pi)
    begin
        if rst_pi = '1' then
            scl_counter <= 0;
            scl_clk <= '0';
        elsif rising_edge(clk_pi) then
            if sda_counter = 1 then
                scl_clk <= not scl_clk;
                scl_counter <= 0;
            else
                scl_counter <= scl_counter + 1;         
            end if;
        end if;
    end process;

    p_seq: process (rst_pi, sda_clk)
    begin
      if rst_pi = '1' then
        c_st <= IDLE;
        counter <= 6;
        sda_po  <= '1';
      elsif rising_edge(sda_clk) then
        case c_st is
            when IDLE =>
                counter <= 6;
                sda_po <= '1';
                c_st <= STARTBIT;
            when STARTBIT =>
                sda_po <= '0';
                c_st <= ADDRESS;
            when ADDRESS =>
                if counter = 0 then
                    sda_po <= addr_pi(counter);
                    counter <= 7;
                    c_st <=  READ_WRITE;  
                else
                    sda_po <= addr_pi(counter);
                    counter <= counter - 1;
                    c_st <=  ADDRESS; 
                end if ;
            when READ_WRITE =>
                sda_po <= rw_pi;
                c_st <=  ADDR_ACKNACK;
            when ADDR_ACKNACK =>
                c_st <=  DATA;
                sda_po <= '0';
            when DATA =>
                if counter = 0 then
                    sda_po <= dat_pi(counter);
                    c_st <=  DATA_ACKNACK;  
                else
                    sda_po <= dat_pi(counter);
                    counter <= counter - 1;
                    c_st <=  DATA;
                end if ;
            when DATA_ACKNACK =>
                sda_po <= '0';
                c_st <=  STOPBIT;
            when STOPBIT =>
                sda_po <= '1';
                c_st <=  IDLE;
            when others =>
                c_st <= IDLE; -- handle parasitic states
                sda_po <= '0';
        end case;
      end if;
    end process;
end rtl;