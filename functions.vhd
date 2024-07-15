library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


package Gates is

component Adder32 is
    Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);
           B : in  STD_LOGIC_VECTOR(7 downto 0);
           Sum : out  STD_LOGIC_VECTOR(7 downto 0);
           CarryOut : out  STD_LOGIC);
end component Adder32;


end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity for 32-bit Adder
entity Adder32 is
    Port ( A : in  STD_LOGIC_VECTOR(7 downto 0);
           B : in  STD_LOGIC_VECTOR(7 downto 0);
           Sum : out  STD_LOGIC_VECTOR(7 downto 0);
           CarryOut : out  STD_LOGIC);
end Adder32;
architecture Behavioral of Adder32 is
begin
    process (A, B)
    variable temp_sum : STD_LOGIC_VECTOR(8 downto 0);
    begin
        temp_sum := ('0' & A) + ('0' & B);
        Sum <= temp_sum(7 downto 0);
        CarryOut <= temp_sum(8);
    end process;
end Behavioral;