-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_e IS
	PORT (
		in_a, in_b : IN unsigned (15 DOWNTO 0) := "0000000000000000";
		flag_z, flag : OUT STD_LOGIC;
		op : IN unsigned(1 DOWNTO 0);
		out_u : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
	);
END ENTITY;

ARCHITECTURE a_ula_e OF ula_e IS

	SIGNAL soma, sub, div, resto : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

	soma <= in_a + in_b;

	sub <= in_a - in_b;

	div <= in_a / in_b WHEN in_b /= "0000000000000000" ELSE
		"0000000000000000";
		
	resto <= in_a REM in_b WHEN in_b /= "0000000000000000" ELSE
		"0000000000000000";

	out_u <= soma WHEN op = "00" ELSE
		sub WHEN op = "01" ELSE
		div WHEN op = "10" ELSE
		resto WHEN op = "11";

	flag_z <= '1' WHEN in_a = in_b AND op = "01" ELSE
		'0';

	flag <= '1' WHEN in_a > in_b ELSE
		'0';

END ARCHITECTURE;