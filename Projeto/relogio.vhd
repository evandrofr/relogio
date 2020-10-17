library ieee;
use ieee.std_logic_1164.all;

entity relogio is
  
  generic ( larguraDados : natural := 8);
  port (
    entradaA_MUX, entradaB_MUX : in std_logic_vector((larguraDados-1) downto 0);
    seletor_MUX : in std_logic;
    saida_MUX : out std_logic_vector((larguraDados-1) downto 0)
  );
end entity;

architecture comportamento of relogio is
  begin
    
end architecture;