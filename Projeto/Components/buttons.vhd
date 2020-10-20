LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY buttons IS
   PORT (
	buttons  : IN STD_LOGIC_VECTOR(3 downto 0);
      enable, rd   : IN STD_LOGIC;
		
      output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE interface OF buttons IS
  
BEGIN
    output <= "0000" & buttons WHEN enable = '1' AND rd = '1' ELSE
    "ZZZZZZZZ";

END ARCHITECTURE interface;