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
	 CLOCK_50   :  IN STD_LOGIC;
    SW         :  IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	 KEY        :  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 ---------------------- OUT --------------------------
	 
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	 LEDR       :  OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END entity;

architecture comportamento of relogio is

  SIGNAL addressProcRAM : STD_LOGIC_VECTOR(larguraDados-1 DOWNTO 0);
  SIGNAL enableWriteRAM : STD_LOGIC;
  SIGNAL enableReadRAM  : STD_LOGIC;
  SIGNAL enableRAM      : STD_LOGIC;
  SIGNAL enableBaseTempo: STD_LOGIC;
  SIGNAL clearBaseTempo : STD_LOGIC;
  SIGNAL dataOutProc    : STD_LOGIC_VECTOR(larguraDados-1 DOWNTO 0);
  SIGNAL dataInProc     : STD_LOGIC_VECTOR(larguraDados-1 DOWNTO 0);
  SIGNAL opCodeSignal   : STD_LOGIC_VECTOR(tamanhoOpCode-1 DOWNTO 0);
  SIGNAL imediatoSignal : STD_LOGIC_VECTOR(larguraDados-1 DOWNTO 0);
  SIGNAL enableSwitches : STD_LOGIC;
  SIGNAL enableButtons  : STD_LOGIC;
  SIGNAL buttonsSignal  : STD_LOGIC_VECTOR(3 DOWNTO 0);
  
  SIGNAL enableDisplaySignal : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL displaySignal0, displaySignal1, displaySignal2, displaySignal3, displaySignal4, displaySignal5 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  
  SIGNAL clkSignal: STD_LOGIC;
  
  BEGIN
	CLOCK : ENTITY work.scale_clock
	PORT MAP(
		 clk_50Mhz  => CLOCK_50,
		 rst        => '0',
		 clk_2Hz    => clkSignal
	);

  
    Processador : ENTITY work.processador
    PORT MAP(
      clk            => CLOCK_50,
      dataIn         => dataInProc, -- dataInProc
      dataOut        => dataOutProc, --MANDAR PARA O DISPLAY ESSE AQUI
		address        => addressProcRAM,
      writeRam       => enableWriteRAM,
      readRam        => enableReadRAM,
		imediatoOut    => imediatoSignal

    );
	 
--	RAM : ENTITY work.memoriaRAM
--   GENERIC MAP (
--         dataWidth => larguraDados,
--         addrWidth => tamanhoRAM
--    )
--    PORT MAP
--    (
--        addr     => addressProcRAM(6 downto 0),
--        we       => enableWriteRAM,
--		  re       => enableReadRAM,
--        habilita => enableRAM, -- vem do decoder
--        clk      => CLOCK_50,
--        dado_in  => dataOutProc,
--        dado_out => dataInProc
--    );
	 
	Decoder : ENTITY work.decoder
    PORT MAP(
		  imediato  => imediatoSignal,
        display   => enableDisplaySignal,
		  enableRAM => enableRAM,
		  enableBaseTempo => enableBaseTempo,
		  clearBaseTempo  => clearBaseTempo,
		  enableSwitches  => enableSwitches,
		  enableButtons   => enableButtons
		  
    );
	 
	 
	 
  -- Segundos
  -- Registrador para unidades de segundos
  REG_SECOND_UNIT : ENTITY work.registradorGenericoWR
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal0,
      ENABLE => enableDisplaySignal(0),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );
	 
  -- Registrador para dezenas de segundos
  REG_SECOND_TEN : ENTITY work.registradorGenericoWR
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal1,
      ENABLE => enableDisplaySignal(1),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );

  -- Minutos
  -- Registrador para unidades de minutos
  REG_MINUTE_UNIT : ENTITY work.registradorGenericoWR 
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal2,
      ENABLE => enableDisplaySignal(2),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );

  -- Registrador para dezenas de minutos
  REG_MINUTE_TEN : ENTITY work.registradorGenericoWR
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal3,
      ENABLE => enableDisplaySignal(3),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );

  -- Horas
  -- Registrador para unidades de horas
  REG_HOUR_UNIT : ENTITY work.registradorGenericoWR 
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal4,
		ENABLE => enableDisplaySignal(4),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );

  -- Registrador para dezenas de horas
  REG_HOUR_TEN : ENTITY work.registradorGenericoWR
  GENERIC MAP(larguraDados => 4)
    PORT MAP(
      DIN => dataOutProc(3 DOWNTO 0),
      DOUT => displaySignal5,
      ENABLE => enableDisplaySignal(5),
		WR => enableWriteRAM,
      CLK => CLOCK_50,
      RST => '0'
    );

	 
	BaseTempo : ENTITY work.divisorGenerico_e_Interface
    PORT MAP(
        clk              => CLOCK_50,
		  habilitaLeitura  => enableBaseTempo,
        limpaLeitura     => clearBaseTempo,
		  leituraUmSegundo => dataInProc,
		  SW               => SW(9)
    );
	 
	 SWITCHES: ENTITY work.switches port map(
		enable   => enableSwitches,
		rd       => enableReadRAM,
		switches => SW(7 DOWNTO 0),
		output   => dataInProc
	);
	
--	detectorSub0: work.edgeDetector port map (clk => CLOCK_50, entrada =>  KEY(0), saida => buttonsSignal(0));
--	detectorSub1: work.edgeDetector port map (clk => CLOCK_50, entrada =>  KEY(1), saida => buttonsSignal(1));
--	detectorSub2: work.edgeDetector port map (clk => CLOCK_50, entrada =>  KEY(2), saida => buttonsSignal(2));
--	detectorSub3: work.edgeDetector port map (clk => CLOCK_50, entrada => KEY(3), saida => buttonsSignal(3));
	
	BUTTONS: ENTITY work.buttons port map(
		buttons => not KEY, --buttonsSignal,
		enable => enableButtons,
		rd    => enableReadRAM,
		output => dataInProc
	);
	 
	 
	 
  DISPLAY0 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal0, saida7seg => HEX0);
  DISPLAY1 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal1, saida7seg => HEX1);
  DISPLAY2 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal2, saida7seg => HEX2);
  DISPLAY3 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal3, saida7seg => HEX3);
  DISPLAY4 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal4, saida7seg => HEX4);
  DISPLAY5 : ENTITY work.conversorHex7Seg PORT MAP(dadoHex => displaySignal5, saida7seg => HEX5);
  
    
END architecture;