-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ULARegs IS
	PORT (
		clock, reset, we3, selecaoMUX : IN STD_LOGIC;
		a1, a2, a3 : IN unsigned (2 DOWNTO 0) := "000";
		operacao : IN unsigned (1 DOWNTO 0) := "00";
		constante : IN unsigned (15 DOWNTO 0) := "0000000000000000";
		out_flagZ : OUT STD_LOGIC;
		out_flag : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE a_ULARegs OF ULARegs IS

	COMPONENT regfile IS
		PORT (
			CLK, RST, WE3 : IN STD_LOGIC;
			A1, A2, A3 : IN unsigned(2 DOWNTO 0) := "000";
			WD3 : IN unsigned (15 DOWNTO 0) := "0000000000000000";
			RD1, RD2 : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
		);
	END COMPONENT;

	COMPONENT ula_e IS
		PORT (
			in_a, in_b : IN unsigned (15 DOWNTO 0) := "0000000000000000";
			flag_z, flag : OUT STD_LOGIC;
			op : IN unsigned(1 DOWNTO 0);
			out_u : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
		);
	END COMPONENT;

	SIGNAL s_RD1 : unsigned(15 DOWNTO 0); -- Saída 1 do banco de registradores
	SIGNAL s_RD2 : unsigned(15 DOWNTO 0); -- Saída 2 do banco de registradores
	SIGNAL s_out_u : unsigned(15 DOWNTO 0); -- Saída da ULA
	SIGNAL s_mux : unsigned(15 DOWNTO 0); -- Saída do mux (seleciona registrador ou constante ext)

BEGIN

	regFile0 : regfile PORT MAP(
		A1 => a1,
		A2 => a2,
		A3 => a3,
		WD3 => s_out_u,
		WE3 => we3,
		CLK => clock,
		RST => reset,
		RD1 => s_RD1,
		RD2 => s_RD2
	);

	u_ULA : ula_e PORT MAP(
		in_a => s_RD1,
		in_b => s_mux,
		op => operacao,
		out_u => s_out_u,
		flag_z => out_flagZ,
		flag => out_flag
	);

	s_mux <= s_RD2 WHEN selecaoMUX = '0' ELSE
		constante WHEN selecaoMUX = '1';

END ARCHITECTURE;