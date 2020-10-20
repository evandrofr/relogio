library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity decoder is
    port
    (		
		  imediato  : in STD_LOGIC_VECTOR(7 downto 0);
		  
        display         : out STD_LOGIC_VECTOR(5 downto 0);
		  enableRAM       : out STD_LOGIC;
		  enableBaseTempo : out STD_LOGIC;
		  clearBaseTempo  : out STD_LOGIC;
		  enableSwitches  : OUT STD_LOGIC;
		  enableButtons   : OUT STD_LOGIC
    );
end entity;

architecture comportamento of decoder is


	constant MOV   : std_logic_vector := "0000";
	constant CMP   : std_logic_vector := "0001";
	constant INC   : std_logic_vector := "0010";
	constant LOAD  : std_logic_vector := "0011";
	constant STORE : std_logic_vector := "0100";
	constant JE    : std_logic_vector := "0101";
	constant JMP   : std_logic_vector := "0110"; 
	
	ALIAS imediatoFirstBit : std_logic IS imediato(7);
	
	ALIAS unidSeg  : std_logic IS display(0);
	ALIAS decSeg   : std_logic IS display(1);
	ALIAS unidMin  : std_logic IS display(2);
	ALIAS decMin   : std_logic IS display(3);
	ALIAS unidHr   : std_logic IS display(4);
	ALIAS decHr    : std_logic IS display(5);
	
    BEGIN

	 unidSeg  <= '1' when unsigned(imediato) = 0 else '0';
	 decSeg   <= '1' when unsigned(imediato) = 1 else '0';
	 unidMin  <= '1' when unsigned(imediato) = 2 else '0';
	 decMin   <= '1' when unsigned(imediato) = 3 else '0';
	 unidHr   <= '1' when unsigned(imediato) = 4 else '0';
	 decHr    <= '1' when unsigned(imediato) = 5 else '0';
	 
	 enableRAM <= '1' when (imediatoFirstBit = '1') else '0';
		
	 enableBaseTempo <= '1' when unsigned(imediato) = 6 else '0';
	 clearBaseTempo  <= '1' when unsigned(imediato) = 7 else '0';
	 
	 enableSwitches <= '1' when (unsigned(imediato) = 8) else '0';
							 
	 enableButtons  <= '1' when (unsigned(imediato) = 9) else '0';
	
END architecture;