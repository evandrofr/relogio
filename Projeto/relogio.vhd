library ieee;
use ieee.std_logic_1164.all;

entity relogio is
  
  GENERIC (
	larguraDados  : natural := 8;
	tamanhoRAM    : natural := 7; -- 2^7 = 128
	tamanhoOpCode : natural := 4
	);
  PORT (
    ---------------------- IN --------------------------
	 CLK_50   :  IN STD_LOGIC;
    SW       :  IN STD_LOGIC_VECTOR(1 down 0);
	 ---------------------- OUT --------------------------
	 
    DISPLAY  :  OUT STD_LOGIC_VECTOR(5 downto 0)
  );
END entity;

architecture comportamento of relogio is
  BEGIN
  
  SIGNAL addressProcRAM: STD_LOGIC_VECTOR(larguraDados-1 downto 0);
  SIGNAL enableWriteRAM: STD_LOGIC;
  SIGNAL enableReadRAM : STD_LOGIC;
  SIGNAL enableRAM     : STD_LOGIC;
  SIGNAL dataOutProc   : STD_LOGIC_VECTOR(larguraDados-1 downto 0);
  SIGNAL dataInProc    : STD_LOGIC_VECTOR(larguraDados-1 downto 0);
  SIGNAL opCodeSignal  : STD_LOGIC_VECTOR(tamanhoOpCode-1 downto 0);
  SIGNAL imediatoSignal: STD_LOGIC_VECTOR(larguraDados-1 downto 0);
  
    Processador : ENTITY work.processador
    PORT MAP(
      clk            => CLK_50,
      dataIn         => dataInProc,
      dataOut        => dataOutProc, --MANDAR PARA O DISPLAY ESSE AQUI
		address        => addressProcRAM,
      writeRam       => enableWriteRAM,
      readRam        => enableReadRAM
		opCodeOut      => opCodeSignal;
		imediatoOut    => imediatoSignal;
    );
	 
	RAM ENTITY work.memoriaRAM
   GENERIC MAP (
         dataWidth => larguraDados,
         addrWidth => tamanhoRAM
    );
    PORT MAP
    (
        addr     => addressProcRAM,
        we       => enableWriteRAM,
		  re       => enableReadRAM,
        habilita => enableRAM, -- vem do decoder
        clk      => CLK_50,
        dado_in  => dataInProc,
        dado_out => dataOutProc
    );
	 
	Decoder : ENTITY work.decoder
    PORT MAP(
        opCode    => opCodeSignal,
		  imediato  => imediatoSignal,
        display   => , --NAO SEI COMO FUNCIONA O DISPLAY
		  enableRAM => enableRAM
    );
	 
	BaseTempo : ENTITY work.divisorGenerico_e_Interface
    PORT MAP(
        clk              => CLK_50,
		  habilitaLeitura  => ,
        limpaLeitura     => ,
		  leituraUmSegundo => 
    );
	 
	 
	 
    
END architecture;