library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
library work;
use work.Gates.all;



entity datapath is
	port(rst, clk : in std_logic);
end entity;

architecture bhv of datapath is 

component memory is
    port (
          m_write: in std_logic;
        m_sel: in std_logic;
        min10, min11, min20, min21: in std_logic_vector(7 downto 0);
        m_A: in std_logic_vector(9 downto 0);
        mout10, mout11, mout12, mout13: out std_logic_vector(7 downto 0);
        clk, rst: in std_logic
    );
end component memory;

component Average is
    Port ( A0,A1,A2,A3: in  STD_LOGIC_VECTOR(7 downto 0);
           Avg0,Avg1 : out  STD_LOGIC_VECTOR(7 downto 0));
end component;

component difference is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           c : in STD_LOGIC_VECTOR (7 downto 0);
           d : in STD_LOGIC_VECTOR (7 downto 0);
           result1 : out  STD_LOGIC_VECTOR (7 downto 0);
	   result2 : out  STD_LOGIC_VECTOR (7 downto 0)
           );
end component;

signal m1_write, m1_sel,m2_write,m2_sel: std_logic;
signal m1_a,m2_a,counter: std_logic_vector(9 downto 0);
signal mout10, mout11, mout12, mout13,A0,A1,A2,A3: std_logic_vector(7 downto 0);
signal min10, min11, min20, min21,m2in20,m2in21,m2in11,m2in10,Avg0,Avg1: std_logic_vector(7 downto 0);
signal m2out10, m2out11, m2out12, m2out13: std_logic_vector(7 downto 0);
signal count:integer:=0;
begin

mem1: memory port map( m_write=>m1_write,
        m_sel=>m1_sel,
        min10=>min10, min11=>min11, min20=>min20, min21=>min21,
        m_A=>m1_a,
        mout10=>mout10, mout11=>mout11, mout12=>mout12, mout13=>mout13,
        clk=>clk, rst=>rst);

av1: Average port map( A0=>mout10,A1=>mout11,A2=>mout12,A3=>mout13,
           Avg0=>m2in10,Avg1=>m2in11);

sub1: difference port map(a=>mout10,
           b =>mout11,
           c =>mout12,
           d =>mout13,
           result1 =>m2in20,
	   result2 =>m2in21);
		
mem2: memory port map( m_write=>m2_write,
        m_sel=>m2_sel,
        min10=>m2in10, min11=>m2in11, min20=>m2in20, min21=>m2in21,
        m_A=>m2_a,
        mout10=>m2out10, mout11=>m2out11, mout12=>m2out12, mout13=>m2out13,
        clk=>clk, rst=>rst);

avg2: Average port map( A0=>m2out10,A1=>m2out11,A2=>m2out12,A3=>m2out13,
           Avg0=>min10,Avg1=>min11);

sub2: difference port map(a=>m2out10,
           b =>m2out11,
           c =>m2out12,
           d =>m2out13,
           result1 =>min20,
	   result2 =>min21);

counter<=std_logic_vector(to_unsigned(count, 10));
		
control: process(clk, rst)
variable level:integer:=0;
begin


	if rst = '0' then
		
		level:=0;
		count <= 0;
		m1_write<='0';
		m1_sel<='0';
		m2_write<='0';
		m2_sel<='0';
		m1_a<=counter;
		m2_a<=counter;
		
	elsif rising_edge(clk) then

	if count = 1023 then
	
		count <=0;
		
		if level=0 then
	
			m1_write<='0';
			m1_sel<='0';
			m2_write<='1';
			m2_sel<='0';
			m1_a<=counter;
			m2_a<=counter;
		
		elsif level=1 then
	
			m1_write<='1';
			m1_sel<='1';
			m2_write<='0';
			m2_sel<='1';
			m1_a<=counter;
			m2_a<=counter;
		end if;
		
		level := level+1;
		
	
	elsif level=0 then
	
		count <= count+1;
		m1_write<='0';
		m1_sel<='0';
		m2_write<='1';
		m2_sel<='0';
		m1_a<=counter;
		m2_a<=counter;
		
	elsif level=1 then
	
		count <= count+1;
		m1_write<='0';
		m1_sel<='0';
		m2_write<='1';
		m2_sel<='0';
		m1_a<=counter;
		m2_a<=counter;
		
	end if;
	end if;
	end process;
		
		
		
end architecture bhv;
		  