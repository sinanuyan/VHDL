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
begin
end TB;