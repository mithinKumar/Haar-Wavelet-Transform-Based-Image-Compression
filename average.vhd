library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.Gates.all;
-- Entity for 32-bit Adder
entity Average is
    Port ( A0,A1,A2,A3: in  STD_LOGIC_VECTOR(7 downto 0);
           Avg0,Avg1 : out  STD_LOGIC_VECTOR(7 downto 0));
end entity;
architecture Behavioral of Average is
signal sum0,sum1:std_logic_vector(7 downto 0);
signal c0,c1:std_logic;
begin
add1:Adder32 
    Port map( A =>A0,
           B=>A1,
           Sum=>sum0,
           CarryOut=>c0);
add2:Adder32 
    Port map( A =>A2,
           B=>A3,
           Sum=>sum1,
           CarryOut=>c1);
avg0<= c0 & sum0(7 downto 1);
avg1<= c1 & sum1(7 downto 1);
end Behavioral;