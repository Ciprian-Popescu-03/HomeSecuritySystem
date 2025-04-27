library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD is
    Port ( 
           digits: in STD_LOGIC_VECTOR (3 downto 0);
           reset:in std_logic;
           clk: in STD_LOGIC;
           window_sensor : in STD_LOGIC;
           door_sensor : in STD_LOGIC;
           motion_sensor : in STD_LOGIC;
           inactive_mode : in STD_LOGIC;              
           home_mode : in STD_LOGIC;                  
           off_mode : in STD_LOGIC; 
           mode_output : out STD_LOGIC_VECTOR(1 downto 0);
           window_signal : out STD_LOGIC;
           door_signal : out STD_LOGIC;
           motion_signal : out STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           code_valid: out STD_LOGIC
         );
end SSD;

architecture Behavioral of SSD is
    
component ssd_1 is
    Port (reset:in std_logic;
          digit0 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit1 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit2 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit3 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit4 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit5 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit6 : in  STD_LOGIC_VECTOR (3 downto 0);
          digit7 : in  STD_LOGIC_VECTOR (3 downto 0);
          clk : in  STD_LOGIC;
          anod : out  STD_LOGIC_VECTOR (7 downto 0);
          catod : out  STD_LOGIC_VECTOR (6 downto 0));
end component ssd_1;

component reverse_counter is
        Port (
            clk: in STD_LOGIC;     -- Clock input
            reset: in STD_LOGIC;     -- Reset input
            stop: in STD_LOGIC;     
            count: out STD_LOGIC_VECTOR(3 downto 0); -- 4-bit count output
            count1: out STD_LOGIC_VECTOR(3 downto 0);
            counter_zero: out STD_LOGIC
        );
end component reverse_counter;

    signal d0out : STD_LOGIC_VECTOR (3 downto 0);
    signal d1out : STD_LOGIC_VECTOR (3 downto 0);
    signal d2out : STD_LOGIC_VECTOR (3 downto 0);
    signal d3out : STD_LOGIC_VECTOR (3 downto 0);
    signal count: STD_LOGIC_VECTOR (3 downto 0);
    signal count1: STD_LOGIC_VECTOR (3 downto 0);
    signal stop: STD_LOGIC := '0';
    signal counter_zero: STD_LOGIC := '0';

begin

    U1: ssd_1 port map(reset => reset,
                       digit0 => d0out, 
                       digit1 => d1out,
                       digit2 => d2out,
                       digit3 => d3out,
                       digit4 => count,
                       digit5 => count1,
                       digit6 => x"0",
                       digit7 => x"0",
                       clk => clk,
                       anod => an,
                       catod => cat
                       );
                       
    U2: reverse_counter port map(
    clk => clk, 
    reset => reset, 
    stop => stop, 
    count => count, -- Include count1 in the port map
    count1 => count1,
    counter_zero => counter_zero
    );               
                       
    process(digits, d0out, d1out, d2out, d3out)
    begin
    
        d0out <= (others => '0');
        d1out <= (others => '0');
        d2out <= (others => '0');
        d3out <= (others => '0');
    
        case digits is
            when "0001" => 
                d0out <= "0001";
            when "0011" => 
                d0out <= "0001";
                d1out <= "0111";
            when "0111" => 
                d0out <= "0001";
                d1out <= "0111";
                d2out <= "0011";
            when "1111" => 
                d0out <= "0001";
                d1out <= "0111";
                d2out <= "0011";
                d3out <= "0110";
            when others => null;
        end case;
    
    end process;

    process(digits, window_sensor, door_sensor, motion_sensor, off_mode, home_mode, inactive_mode)
    begin
        -- Default values for mode outputs and sensor signals
        mode_output <= "00";
        door_signal <= '0';
        window_signal <= '0';
        motion_signal <= '0';
        
        if counter_zero = '0' then
            if digits = "1111" then
            stop <= '1';
            code_valid <= '1';
        
            if off_mode = '1' then
                mode_output <= "11";
                door_signal <= door_sensor;
                window_signal <= window_sensor;
                motion_signal <= motion_sensor;
            elsif home_mode = '1' then
                mode_output <= "10";
                door_signal <= door_sensor;
                window_signal <= window_sensor;
            elsif inactive_mode = '1' then
                mode_output <= "01";
            end if;
            
            else code_valid <= '0';  
            
            end if;
        else
            code_valid <= '0';
            window_signal <= '0';
            door_signal <= '0';
            motion_signal <= '0';
        end if;
    end process;

end Behavioral;