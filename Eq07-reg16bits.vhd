-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg16bits IS
	PORT (
		clkREG, rstREG, wr_en_REG : IN STD_LOGIC;
		data_in_REG : IN unsigned(15 DOWNTO 0) := "0000000000000000";
		data_out_REG : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
	);
END ENTITY;

ARCHITECTURE a_reg16bits OF reg16bits IS
	SIGNAL registro : unsigned(15 DOWNTO 0) := "0000000000000000";
BEGIN
	PROCESS (clkREG, rstREG, wr_en_REG) -- acionado se houver mudança em clk, rst ou wr_en
	BEGIN
		IF rstREG = '1' THEN
			registro <= "0000000000000000";
		ELSIF wr_en_REG = '1' THEN
			IF rising_edge(clkREG) THEN
				registro <= data_in_REG;
			END IF;
		END IF;
	END PROCESS;
	data_out_REG <= registro; -- conexao direta, fora do processo
END ARCHITECTURE;