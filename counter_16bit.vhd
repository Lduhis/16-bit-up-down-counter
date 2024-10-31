library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter_16bit is
Generic (N : integer := 16 );
Port (clk : in std_logic;
      rst : in std_logic;
      up_down : in std_logic;
      count : out std_logic_vector(N-1 downto 0));
end counter_16bit;

architecture Behavioral of counter_16bit is

signal tmp_count : integer range 0 to 2**N-1 := 0;
begin

process(clk, rst) begin

    if rst = '1' then      
        tmp_count <= 0;
     
    elsif rising_edge(clk) then
        if up_down = '1' then  
        -- Increment counter, wrap to 0 on overflow
            if tmp_count < 2**N-1 then       
                tmp_count <= tmp_count + 1;
            else
                tmp_count <= 0; -- Overflow wrap-around
            end if;
            
         else
         -- Decrement counter, wrap to max value on underflow
            if tmp_count > 0 then
                tmp_count <= tmp_count - 1;
            else
                tmp_count <= 2**N-1; -- Underflow wrap-around
            end if;  
              
        end if;
    end if;    
end process;  

-- Convert integer to std_logic_vector for output
count <= std_logic_vector(to_unsigned(tmp_count, N));
          
end Behavioral;
