library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 16;
          addrWidth: natural := 8
    );
   port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture assincrona of memoriaROM is

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
  BEGIN
        -- Inicializa os endereços:
		tmp(0) := "0000000000000000";
		tmp(1) := "0000000100000000";
		tmp(2) := "0000001000000000";
		tmp(3) := "0000001100000000";
		tmp(4) := "0000010000000000";
		tmp(5) := "0000010100000000";
		tmp(6) := "0000100100000000";
		tmp(7) := "0000011000000000";
		tmp(8) := "0000011100000000";
		tmp(9) := "0000100000000000";
		tmp(10) := "0011100100000110";
		tmp(11) := "0001100100000001";
		tmp(12) := "0101000000001111";
		tmp(13) := "0011100100000111";
		tmp(14) := "0110000000001010";
		tmp(15) := "0011100100000111";
		tmp(16) := "0100000000000000";
		tmp(17) := "0100000100000001";
		tmp(18) := "0100001000000010";
		tmp(19) := "0100001100000011";
		tmp(20) := "0100010000000100";
		tmp(21) := "0100010100000101";
		tmp(22) := "0010000000000001";
		tmp(23) := "0001000000001010";
		tmp(24) := "0101000000011010";
		tmp(25) := "0110000000001010";
		tmp(26) := "0000000000000000";
		tmp(27) := "0010000100000001";
		tmp(28) := "0001000100000110";
		tmp(29) := "0101000000011111";
		tmp(30) := "0110000000001010";
		tmp(31) := "0000000100000000";
		tmp(32) := "0010001000000001";
		tmp(33) := "0001001000001010";
		tmp(34) := "0101000000100100";
		tmp(35) := "0110000000001010";
		tmp(36) := "0000001000000000";
		tmp(37) := "0010001100000001";
		tmp(38) := "0001001100000110";
		tmp(39) := "0101000000101001";
		tmp(40) := "0110000000001010";
		tmp(41) := "0000001100000000";
		tmp(42) := "0010010000000001";
		tmp(43) := "0001010000001010";
		tmp(44) := "0101000000110000";
		tmp(45) := "0001010000000100";
		tmp(46) := "0101000000110011";
		tmp(47) := "0110000000001010";
		tmp(48) := "0000010000000000";
		tmp(49) := "0010010100000001";
		tmp(50) := "0110000000001010";
		tmp(51) := "0001010100000010";
		tmp(52) := "0101000000110110";
		tmp(53) := "0110000000001010";
		tmp(54) := "0000010000000000";
		tmp(55) := "0000010100000000";
		tmp(56) := "0110000000001010";
      return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;