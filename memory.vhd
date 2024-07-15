library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port (
        m_write: in std_logic;
        m_sel: in std_logic;
        min10, min11, min20, min21: in std_logic_vector(7 downto 0);
        m_A: in std_logic_vector(9 downto 0);
        mout10, mout11, mout12, mout13: out std_logic_vector(7 downto 0);
        clk, rst: in std_logic
    );
end entity memory;

architecture a of memory is
    type mem is array (0 to 4095) of std_logic_vector(7 downto 0);
    signal data: mem := (others => (others => '0'));
    signal i, j, k,k2: integer := 0;

begin

    process (m_A,i,j,k,k2)
    begin
        i <= to_integer(unsigned(m_A));
        j <= i / 16;
        k <= 4 * 64 * (i rem 16);
		  k2<=k/2;
    end process;

    process (clk, rst,i,j,k,k2)
    begin
        if rst = '1' then
            data <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if m_write = '1' then
                if m_sel = '0' then
                    data(i * 2) <= min10;
                    data((i * 2) + 1) <= min11;
                    

                    data((i * 2) + 32) <= min20;
                    data((i * 2) + 33) <= min21;
                    
                else
                    data(j + k2) <= min10;
                    data(j + 64 + k2) <= min11;
                    

                    data(j + 2048 + k2) <= min20;
                    data(j + 64 + k2 + 20248)<= min21;
                   
                end if;
            end if;
        end if;
    end process;

    process (m_A, data, m_sel,i,j,k,k2)
    begin
        if m_sel = '0' then
            mout10 <= data(4 * i);
            mout11 <= data((4 * i) + 1);
            mout12 <= data((4 * i) + 2);
            mout13 <= data((4 * i) + 3);

            
        else
            mout10 <= data(j + k);
            mout11 <= data(j + 64 + k);
            mout12 <= data(j + 128 + k);
            mout13 <= data(j + 192 + k);

           
        end if;
    end process;

end architecture a;