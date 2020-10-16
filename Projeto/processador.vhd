library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity processador is
	GENERIC (
		ADDR_WIDTH_REG : NATURAL := 8;
		DATA_WIDTH_ROM : NATURAL := 16;
		ADDR_WIDTH_ROM : NATURAL := 8;
		OPCODE_WIDTH   : NATURAL := 4;
		CONTROLE_WIDTH : NATURAL := 9;
		NUMBER_OF_REGS : NATURAL := 4
	);
     port
    (
		  -------------IN-------------
		  dataIn: in STD_LOGIC_VECTOR(7 downto 0);
		  clk: in STD_LOGIC;
		  -------------OUT------------
		  address: out STD_LOGIC_VECTOR(7 downto 0);
        dataOut:  out STD_LOGIC_VECTOR(7 downto 0);
		  writeRam: out STD_LOGIC;
		  readRam: out STD_LOGIC
		  
    );
end entity;

architecture comportamento of processador is

	SIGNAL muxPCSignal : STD_LOGIC_VECTOR(ADDR_WIDTH_REG -1 downto 0);
	SIGNAL PCROMSignal : STD_LOGIC_VECTOR(ADDR_WIDTH_REG -1 downto 0);
	SIGNAL somadorMuxSignal : STD_LOGIC_VECTOR(ADDR_WIDTH_REG - 1 downto 0);
	SIGNAL muxImeRamUlaA    : STD_LOGIC_VECTOR(ADDR_WIDTH_REG - 1 downto 0);
	SIGNAL UlaRegSignal     : STD_LOGIC_VECTOR(ADDR_WIDTH_REG - 1 downto 0);
	SIGNAL RegUlaBMemSignal  : STD_LOGIC_VECTOR(ADDR_WIDTH_REG - 1 downto 0);
	SIGNAL flagZeroSignal    : STD_LOGIC;
	SIGNAL barramentoSignal  : STD_LOGIC_VECTOR(DATA_WIDTH_ROM - 1 downto 0);
	SIGNAL pontosDeContoleSignal : STD_LOGIC_VECTOR(CONTROLE_WIDTH - 1 downto 0);
	
	SIGNAL instrucao : STD_LOGIC_VECTOR(DATA_WIDTH_ROM -1 downto 0);
	SIGNAL pontosDeControleSignal : STD_LOGIC_VECTOR(CONTROLE_WIDTH -1 downto 0);
	
	ALIAS imediato  : STD_LOGIC_VECTOR(ADDR_WIDTH_REG -1 downto 0) IS barramentoSignal(7 downto 0);
	ALIAS addrROM : STD_LOGIC_VECTOR(ADDR_WIDTH_REG -1 downto 0) IS barramentoSignal(7 downto 0);
	ALIAS opCode  : STD_LOGIC_VECTOR(OPCODE_WIDTH -1 downto 0) IS barramentoSignal(15 downto 12);
	ALIAS addrReg : STD_LOGIC_VECTOR(NUMBER_OF_REGS -1 downto 0) IS barramentoSignal(11 downto 8);
	
	ALIAS selMuxPc : STD_LOGIC IS pontosDeControleSignal(0);
	ALIAS selMuxImeRam: STD_LOGIC IS pontosDeControleSignal(1);
	ALIAS enableRegs: STD_LOGIC IS pontosDeContoleSignal(2);
	ALIAS operacoes: STD_LOGIC_VECTOR(2 downto 0) IS pontosDeControleSignal(5 downto 3);
	ALIAS enableReadRam: STD_LOGIC IS pontosDeControleSignal(6);
	ALIAS enableWriteRam: STD_LOGIC IS pontosDeControleSignal(7);
	
	CONSTANT INC : NATURAL := 1;
	
    BEGIN
	 
      PC : ENTITY work.registradorGenerico
        GENERIC MAP(
            larguraDados => ADDR_WIDTH_REG
        )
        PORT MAP(
            DIN    => muxPCSignal,
            DOUT   => PCROMSignal,
            ENABLE => '1',
            CLK    => clk,
            RST    => '0'
        );
		  
		MuxPC : ENTITY work.muxGenerico2x1
        GENERIC MAP(
            larguraDados => ADDR_WIDTH_REG
        )
        PORT MAP(
            entradaA_MUX => addrROM, 
            entradaB_MUX => somadorMuxSignal, 
            seletor_MUX  => selMuxPc,
            saida_MUX    => muxPCSignal
        );
		  
		  
    somaUm : ENTITY work.somaConstante
        GENERIC MAP(
            larguraDados => ADDR_WIDTH_REG,
            constante    => INC
        )
        PORT MAP(
            entrada => PCROMSignal,
            saida   => somadorMuxSignal
        );

	 ROM : ENTITY work.memoriaROM
        GENERIC MAP(
            dataWidth => DATA_WIDTH_ROM,
            addrWidth => ADDR_WIDTH_ROM
        )
        PORT MAP(
            Endereco => PCROMSignal,
            Dado     => instrucao
        );
		  
	UNIDCONTROLE : ENTITY work.unidControl
		PORT MAP(
		opCode => opCode,
		flagZero => flagZeroSignal,
		pontosDeControle => pontosDeContoleSignal
		);
		
	 muxRAM_Imediato : ENTITY work.muxGenerico2x1
        GENERIC MAP(
            larguraDados => ADDR_WIDTH_REG
        )
        PORT MAP(
            entradaA_MUX => dataIn,
            entradaB_MUX => imediato,
            seletor_MUX  => selMuxImeRam,
            saida_MUX    => muxImeRamUlaA
        );
		  
		 BancoRegistradores : ENTITY work.bancoRegistradoresArqRegMem
        GENERIC MAP(
		  larguraDados => ADDR_WIDTH_REG,
		  larguraEndBancoRegs => NUMBER_OF_REGS
		  )
        PORT MAP(
            clk             => clk,
            endereco        => addrReg,
            dadoEscrita     => UlaRegSignal,
            habilitaEscrita => enableRegs,
            saida           => RegUlaBMemSignal
				);
				
		
    ULA : ENTITY work.ULA
        GENERIC MAP(
            larguraDados => ADDR_WIDTH_REG
        )
        PORT MAP(
            entradaA  => muxImeRamUlaA,
            entradaB  => RegUlaBMemSignal,
            saida     => UlaRegSignal,
            seletor   => operacoes,
            flagZero => flagZeroSignal
        );
		  
END architecture;