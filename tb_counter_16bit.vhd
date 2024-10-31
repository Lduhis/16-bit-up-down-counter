library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_counter_16bit is
Generic (N : integer := 16 );
end tb_counter_16bit;

architecture Behavioral of tb_counter_16bit is

component counter_16bit is
Generic (N : integer := 16 );
Port (clk : in std_logic;
      rst : in std_logic;
      up_down : in std_logic;
      count : out std_logic_vector(N-1 downto 0));
end component counter_16bit;

constant c_clkperiod : time:= 10us;

signal clk : std_logic;
signal rst : std_logic;
signal up_down : std_logic;
signal count : std_logic_vector(N-1 downto 0);

begin

DUT: counter_16bit
Generic map(N => N)

Port map (clk => clk,
          rst => rst,
          up_down => up_down,
          count => count);
        
P_CLKGEN : process begin 

clk <= '0';  
wait for c_clkperiod/2;
clk <= '1';
wait for c_clkperiod/2;

end process P_CLKGEN;

P_STIMULI : process begin

rst <= '1';
up_down <= '0';
wait for c_clkperiod*10;
rst <= '0';
wait for c_clkperiod*10;
assert false;
report "SIM DONE"
severity failure;

end process;
end Behavioral;