library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reverse_counter is
    Port (
        clk   : in  STD_LOGIC;     -- Clock input
        reset : in  STD_LOGIC;     -- Reset input
        stop  : in  STD_LOGIC;     
        count : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit count output
        count1 : out STD_LOGIC_VECTOR(3 downto 0);
        digit0  : out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit SSD digit output
        digit1  : out STD_LOGIC_VECTOR(3 downto 0);
        digit2  : out STD_LOGIC_VECTOR(3 downto 0);
        digit3  : out STD_LOGIC_VECTOR(3 downto 0);
        digit4  : out STD_LOGIC_VECTOR(3 downto 0);
        digit5  : out STD_LOGIC_VECTOR(3 downto 0);
        digit6  : out STD_LOGIC_VECTOR(3 downto 0);
        digit7  : out STD_LOGIC_VECTOR(3 downto 0);
        counter_zero : out STD_LOGIC
    );
end reverse_counter;

architecture Behavioral of reverse_counter is

component clock_divider is
    Port (
        clk_in  : in  STD_LOGIC;  -- Input clock
        reset   : in  STD_LOGIC;  -- Reset signal
        clk_out : out STD_LOGIC   -- Output divided clock
    );
end component clock_divider;

    signal count_reg : STD_LOGIC_VECTOR(3 downto 0) := "0101";
    signal count_reg1 : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    signal counting  : STD_LOGIC := '1';
    signal slow_clk  : STD_LOGIC;
begin

    U1: clock_divider port map(clk_in => clk, reset => reset, clk_out => slow_clk);
    
    process(slow_clk, reset)
    begin
        if reset = '1' then
            count_reg <= "0101";
            count_reg1 <= "0001";
            counting <= '1';
            counter_zero <= '0';
        elsif rising_edge(slow_clk) then
            if stop = '1' then
                count_reg <= "0000";
                count_reg1 <= "0000";
                counting <= '0';
            elsif counting = '1' then
                count_reg <= count_reg - 1;
                if count_reg = "0000" and count_reg1 = "0001" then
                    count_reg1 <= count_reg1 - 1;
                    count_reg <= "1001";
                end if;
                if count_reg = "0001" and count_reg1 = "0000" then
                    counting <= '0';
                    counter_zero <= '1';
                end if;
            end if;
        end if;
    end process;

    count <= count_reg;
    count1 <= count_reg1;
    
    digit0 <= count_reg;
    -- Set other digits to zero
    digit1 <= count_reg1;
    digit2 <= "0000";
    digit3 <= "0000";
    digit4 <= "0000";
    digit5 <= "0000";
    digit6 <= "0000";
    digit7 <= "0000";


end Behavioral;
