library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity unidControl is
    port
    (
        opCode: in STD_LOGIC_VECTOR(4 downto 0);
		  flagZero : in std_logic;
		  
		  
        pontosDeControle:  out STD_LOGIC_VECTOR(8 downto 0)
		  
    );
end entity;

architecture comportamento of unidControl is

SIGNAL pontosDeControleSignal : STD_LOGIC_VECTOR(8 downto 0);

ALIAS selMuxPc : std_logic IS pontosDeControleSignal(0);
ALIAS selMuxImeRam: std_logic IS pontosDeControleSignal(1);
ALIAS enableRegs: std_logic IS pontosDeControleSignal(2);
ALIAS operacoes: std_logic_vector IS pontosDeControleSignal(6 downto 3);
ALIAS enableReadRam: std_logic IS pontosDeControleSignal(7);
ALIAS enableWriteRam: std_logic IS pontosDeControleSignal(8);

constant MOV : std_logic_vector := "0000";
constant CMP : std_logic_vector := "0001";
constant INC : std_logic_vector := "0010";
constant LOAD : std_logic_vector := "0011";
constant STORE : std_logic_vector := "0100";
constant JE : std_logic_vector := "0101";
constant JMP : std_logic_vector := "0110"; 

    begin
       selMuxPc <= '1' when opCode = JMP or (opCode = JE AND flagZero = '1') else '0';
		 selMuxImeRam <= '1' when opCode = CMP or opCode = INC or opCode = MOV else '0';
		 enableRegs <= '1' when opCode = MOV or opCode = INC or opCode = LOAD else '0';
		 enableReadRam <= '1' when opCode = LOAD else '0';
		 enableWriteRam <= '1' when opCode = STORE else '0';
		 
		 operacoes <= "000"; -- default and INC 
		 operacoes <= "001" when opCode = CMP;
		 operacoes <= "010" when opCode = LOAD or OpCode = MOV;
		 
		 pontosDeControle <= pontosDeControleSignal;
		 
end architecture;