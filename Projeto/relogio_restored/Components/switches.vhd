LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY switches IS
   PORT (
      input  : IN STD_LOGIC_VECTOR(1 downto 0);
		switches  : IN STD_LOGIC_VECTOR(1 downto 0);
      output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE interface OF switches IS
  
BEGIN
	 output <= "0000000" & switches(0) WHEN input(0) = '1' ELSE
				  "0000000" & switches(1) WHEN input(1) = '1' ELSE
              (OTHERS => 'Z');

END ARCHITECTURE interface;