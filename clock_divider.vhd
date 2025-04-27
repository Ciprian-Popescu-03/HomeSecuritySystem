library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
    Port (
        clk_in  : in  STD_LOGIC;  -- Input clock
        reset   : in  STD_LOGIC;  -- Reset signal
        clk_out : out STD_LOGIC   -- Output divided clock
    );
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter : INTEGER := 0;
    signal clk_reg : STD_LOGIC := '0';
    constant DIVISOR : INTEGER := 50000000; -- 50 MHz / 1 Hz = 50,000,000
begin

    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_reg <= '0';
        elsif rising_edge(clk_in) then
            if counter = DIVISOR - 1 then
                counter <= 0;
                clk_reg <= not clk_reg; -- Toggle the output clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;
end Behavioral;
