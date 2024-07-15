library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity difference is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           c : in STD_LOGIC_VECTOR (7 downto 0);
           d : in STD_LOGIC_VECTOR (7 downto 0);
           result1 : out  STD_LOGIC_VECTOR (7 downto 0);
	   result2 : out  STD_LOGIC_VECTOR (7 downto 0)
           );
end entity;

architecture Behavioral of difference is
    signal result10 : STD_LOGIC_VECTOR(8 downto 0);
    signal result20,result3,result4 : STD_LOGIC_VECTOR(8 downto 0);
    signal a_signed : STD_LOGIC_VECTOR(7 downto 0);
    signal b_signed : STD_LOGIC_VECTOR(7 downto 0);
    signal c_signed : STD_LOGIC_VECTOR(7 downto 0);
    signal d_signed : STD_LOGIC_VECTOR(7 downto 0);
begin

    a_signed <= a;
    b_signed <= b;
    c_signed <= c;
    d_signed <= d;
    

    result10 <= ('0' & a_signed) - ('0' & b_signed);
    
    result20 <= ('0' & b_signed) - ('0' & a_signed);

    result3<= ('0' & c_signed) - ('0' & d_signed);
    
    result4<= ('0' & d_signed) - ('0' & c_signed);


    process(result10, result20,result3,result4)
    begin
   if result10(8) = '1' then  
            result1 <= STD_LOGIC_VECTOR(result20(7 downto 0));
	else
            result1 <= STD_LOGIC_VECTOR(result10(7 downto 0));
	end if;
        
  	if result3(8) = '1' then  
            result2 <= STD_LOGIC_VECTOR(result4(7 downto 0));

	else result2 <= STD_LOGIC_VECTOR(result3(7 downto 0));
            
   end if;
    end process;

end Behavioral;