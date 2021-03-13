library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master is
    generic(
      CLK_FREQ      : natural := 12000000;
      BAUD       :   natural := 100000
    );
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

  -- number of bits in frame: 
  -- 1 Bit START
  -- 7 Bit ADDRESS
  -- 1 Bit READ/WRITE
  -- 1 Bit ACK/NACK
  -- 8 Bit DATA
  -- 1 Bit ACK/NACK
  -- 1 Bit STOP
  constant FRAME      :   natural := 20;

  constant FULL_BIT  : natural := ( CLK_FREQ / BAUD - 1 ) / 2;
  constant HALF_BIT  : natural := FULL_BIT / 2;
  constant GAP_WIDTH : natural := FULL_BIT * 4;

  signal counter      :   natural range 0 to 8 := 7;
  signal half_counter :   integer := 0;
  signal sda_clk      :   std_logic := '0';
  signal scl_clk      :   std_logic := '0';
  signal full_clk_toggle: std_logic;

  type state is (IDLE, STARTBIT, ADDRESS, READ_WRITE, ADDR_ACKNACK, DATA, DATA_ACKNACK, STOPBIT);
  signal c_st, n_st: state;
begin
    p_seq: process (rst_pi, clk_pi)
    begin
      if rst_pi = '1' then
        c_st <= IDLE;
        counter <= 0;
        sda_po  <= '1';
      elsif rising_edge(clk_pi) then
        if counter = 3 then
            scl_clk <= not scl_clk;
            counter <= 0;
        else
            counter <= counter + 1;
        end if;
      end if;
      scl_po <= scl_clk;
    end process;
end rtl;