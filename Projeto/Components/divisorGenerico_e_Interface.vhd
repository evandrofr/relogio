LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity divisorGenerico_e_Interface is
   port(clk      :   in std_logic;
      habilitaLeitura : in std_logic;
      limpaLeitura : in std_logic;
		seletor      : in std_logic;
      leituraUmSegundo :   out std_logic_vector(7 downto 0)
   );
end entity;

architecture interface of divisorGenerico_e_Interface is
  signal sinalUmSegundo : std_logic;
  signal saidaclk_reg1seg, saidaclk_regRap : std_logic;
begin

	baseTempo: entity work.divisorGenerico
				  generic map (
				  divisor => 25000000
				  )   -- 1s
				  port map (
				  clk => clk,
				  saida_clk => saidaclk_reg1seg);
				  
	baseTempoRapido: entity work.divisorGenerico
				  generic map (
				  divisor => 250000
				  )   -- Rapido
				  port map (
				  clk => clk,
				  saida_clk => saidaclk_regRap);

	registraUmSegundo: entity work.flipflop
		port map (DIN => '1',
					 DOUT => sinalUmSegundo,
					 ENABLE => '1',
					 CLK => saidaclk_reg1seg,
					 RST => limpaLeitura);
					 
	saidaclk_reg1seg <= saidaclk_regRap WHEN seletor = '1' ELSE
      saidaclk_reg1seg;
			


-- Faz o tristate de saida:
leituraUmSegundo <= ("0000000" & sinalUmSegundo) when habilitaLeitura = '1' else (OTHERS => 'Z');

end architecture interface;