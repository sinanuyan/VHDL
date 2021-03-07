library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uart_tx is
    port(
        clk: in  std_logic;
        rst_pi : in std_logic;
        tx: out std_logic;
        clk_out : out std_logic
    );
end uart_tx;

architecture rtl of uart_tx is
    component clock is
        port(
            clk_pi: in  std_logic;
            clk_uart: out std_logic
          );
    end component clock;

    signal clock_uart    : std_logic;
    signal tx_buffer:   unsigned(7 downto 0) := "01000001";

    type state is (IDLE, STARTBIT, BIT0, BIT1, BIT2, BIT3, BIT4, BIT5, BIT6, BIT7, STOPBIT);
    signal c_st, n_st: state;
begin
    CLK_1HZ : clock
    port map(
        clk_pi => clk,
        clk_uart => clock_uart
      );

    p_seq: process (rst_pi, clock_uart)
    begin
      if rst_pi = '1' then
        c_st <= IDLE;
      elsif rising_edge(clock_uart) then
        c_st <= n_st;
      end if;
    end process;

    p_uart_tx: process (c_st)
    begin   
        n_st <= c_st; -- remain in current state
        case c_st is
            when IDLE =>
                n_st <= STARTBIT;
                tx <= '1';
            when STARTBIT =>
                n_st <= BIT0;
                tx <= '0';
            when BIT0 =>
                n_st <= BIT1;
                tx <= tx_buffer(0);
            when BIT1 =>
                n_st <= BIT2;
                tx <= tx_buffer(1);
            when BIT2 =>
                n_st <= BIT3;
                tx <= tx_buffer(2);
            when BIT3 =>
                n_st <= BIT4;
                tx <= tx_buffer(3);
            when BIT4 =>
                n_st <= BIT5;
                tx <= tx_buffer(4);
            when BIT5 =>
                n_st <= BIT6;
                tx <= tx_buffer(5);
            when BIT6 =>
                n_st <= BIT7;
                tx <= tx_buffer(6);
            when BIT7 =>
                n_st <= STOPBIT;
                tx <= tx_buffer(7);
            when STOPBIT =>
                n_st <= IDLE;
                tx <= '1';
            when others =>
                n_st <= IDLE; -- handle parasitic states
                tx <= '1';
        end case;
    end process;
    clk_out <= clock_uart;
end rtl;