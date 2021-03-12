library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_i2c_master is
end tb_i2c_master;

architecture TB of tb_i2c_master is
    component i2c_master is
        port(
            clk_pi      : in    std_logic;
            rst_pi      : in    std_logic;
            addr_pi     : in    std_logic_vector(6 downto 0);
            dat_pi      : in    std_logic_vector(7 downto 0);
            rw_pi       : in    std_logic;
            sda_po      : out   std_logic;
            scl_po      : out   std_logic
        );
    end component i2c_master;

    constant CLK_FRQ : integer := 100_000_000; -- 100 MHz

    -- testbench signals
    signal rst       : std_logic := '1';
    signal clk       : std_logic := '0';
    signal addr      : std_logic_vector(6 downto 0) := "1010101";
    signal dat       : std_logic_vector(7 downto 0) := "10101010";
    signal rw        : std_logic := '0';
    signal sda       : std_logic;
    signal scl       : std_logic;

    -- simulation control signals
    signal sim_done : boolean := false;
    signal counter  : integer := 0;

begin
    i2c_master_b : i2c_master
    port map(
      rst_pi        => rst,
      clk_pi        => clk, 
      addr_pi       => addr,
      dat_pi        => dat,
      rw_pi         => rw,
      sda_po        => sda,
      scl_po        => scl
      );

    -- generate reset
    rst <= '1', '0' after  1 sec / CLK_FRQ;

      -- clock generation
    p_clk: process
    begin
        if not sim_done then
            if counter = 500 then
                sim_done <= true;
            else
                counter <= counter + 1;
            end if;
        wait for 1 sec / CLK_FRQ/2;
        clk <= not clk;
        else
            wait;
        end if;
    end process;
end TB;