LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY switches IS
   PORT (
      enable    : IN STD_LOGIC;
		switches  : IN STD_LOGIC_VECTOR(7 downto 0);
		rd        : IN STD_LOGIC;
      output    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE interface OF switches IS
  
BEGIN
	 output <=  switches WHEN enable = '1' AND rd = '1' ELSE
              (OTHERS => 'Z');

END ARCHITECTURE interface;