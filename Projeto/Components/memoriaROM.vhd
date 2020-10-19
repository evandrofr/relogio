library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 8;
          addrWidth: natural := 3
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
		tmp(10) := "0011011000000111";
		tmp(11) := "0100000000000000";
		tmp(12) := "0100000100000001";
		tmp(13) := "0100001000000010";
		tmp(14) := "0100001100000011";
		tmp(15) := "0100010000000100";
		tmp(16) := "0100010100000101";
		tmp(17) := "0001011000000000";
		tmp(18) := "0101000000100010";
		tmp(19) := "0011011100001001";
		tmp(20) := "0011100000001010";
		tmp(21) := "0001011100000001";
		tmp(22) := "0101000000011010";
		tmp(23) := "0001100000000001";
		tmp(24) := "0101000000011110";
		tmp(25) := "0110000000001010";
		tmp(26) := "0011011100001001";
		tmp(27) := "0001011100000000";
		tmp(28) := "0101000000110010";
		tmp(29) := "0110000000011010";
		tmp(30) := "0011100000001010";
		tmp(31) := "0001100000000000";
		tmp(32) := "0101000000111100";
		tmp(33) := "0110000000011110";
		tmp(34) := "0011100100000110";
		tmp(35) := "0001100100000001";
		tmp(36) := "0101000000100110";
		tmp(37) := "0110000000001010";
		tmp(38) := "0000000000001001";
		tmp(39) := "0100100100000110";
		tmp(40) := "0010000000000001";
		tmp(41) := "0001000000001010";
		tmp(42) := "0101000000101100";
		tmp(43) := "0110000000001010";
		tmp(44) := "0000000000000000";
		tmp(45) := "0010000100000001";
		tmp(46) := "0001000100000110";
		tmp(47) := "0101000000110001";
		tmp(48) := "0110000000001010";
		tmp(49) := "0000000100000000";
		tmp(50) := "0010001000000001";
		tmp(51) := "0001001000001010";
		tmp(52) := "0101000000110110";
		tmp(53) := "0110000000001010";
		tmp(54) := "0000001000000000";
		tmp(55) := "0010001100000001";
		tmp(56) := "0001001100000110";
		tmp(57) := "0101000000111011";
		tmp(58) := "0110000000001010";
		tmp(59) := "0000001100000000";
		tmp(60) := "0010010000000001";
		tmp(61) := "0001010000001010";
		tmp(62) := "0101000001000010";
		tmp(63) := "0001010000000100";
		tmp(64) := "0101000001000101";
		tmp(65) := "0110000000001010";
		tmp(66) := "0000010000000000";
		tmp(67) := "0010010100000001";
		tmp(68) := "0110000000001010";
		tmp(69) := "0001010100000010";
		tmp(70) := "0101000001001000";
		tmp(71) := "0110000000001010";
		tmp(72) := "0000010000000000";
		tmp(73) := "0000010100000000";
		tmp(74) := "0110000000001010";
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;