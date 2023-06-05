-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY regfile IS
  PORT (
    CLK, RST, WE3 : IN STD_LOGIC;
    A1, A2, A3 : IN unsigned(2 DOWNTO 0) := "000";
    WD3 : IN unsigned(15 DOWNTO 0) := "0000000000000000";
    RD1, RD2 : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
  );
END ENTITY;

ARCHITECTURE a_regfile OF regfile IS

  COMPONENT reg16bits
    PORT (
      clkREG, rstREG, wr_en_REG : IN STD_LOGIC;
      data_in_REG : IN unsigned(15 DOWNTO 0) := "0000000000000000";
      data_out_REG : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
    );
  END COMPONENT;

  SIGNAL s_reg_0, s_reg_1, s_reg_2, s_reg_3, s_reg_4, s_reg_5, s_reg_6, s_reg_7 : unsigned(15 DOWNTO 0) := "0000000000000000";
  SIGNAL s_wr_en_0, s_wr_en_1, s_wr_en_2, s_wr_en_3, s_wr_en_4, s_wr_en_5, s_wr_en_6, s_wr_en_7 : STD_LOGIC;
  SIGNAL decoder : unsigned(6 DOWNTO 0) := "0000000";

BEGIN
  reg_0 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_0,
    data_in_REG => WD3,
    data_out_REG => s_reg_0
  );

  reg_1 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_1,
    data_in_REG => WD3,
    data_out_REG => s_reg_1
  );

  reg_2 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_2,
    data_in_REG => WD3,
    data_out_REG => s_reg_2
  );

  reg_3 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_3,
    data_in_REG => WD3,
    data_out_REG => s_reg_3
  );

  reg_4 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_4,
    data_in_REG => WD3,
    data_out_REG => s_reg_4
  );

  reg_5 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_5,
    data_in_REG => WD3,
    data_out_REG => s_reg_5
  );

  reg_6 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_6,
    data_in_REG => WD3,
    data_out_REG => s_reg_6
  );

  reg_7 : reg16bits PORT MAP(
    clkREG => CLK,
    rstREG => RST,
    wr_en_REG => s_wr_en_7,
    data_in_REG => WD3,
    data_out_REG => s_reg_7
  );

  decoder <= "0000001" WHEN A3 = "001" ELSE
    "0000010" WHEN A3 = "010" ELSE
    "0000100" WHEN A3 = "011" ELSE
    "0001000" WHEN A3 = "100" ELSE
    "0010000" WHEN A3 = "101" ELSE
    "0100000" WHEN A3 = "110" ELSE
    "1000000" WHEN A3 = "111";

  s_wr_en_0 <= '0';
  s_wr_en_1 <= decoder(0) AND WE3;
  s_wr_en_2 <= decoder(1) AND WE3;
  s_wr_en_3 <= decoder(2) AND WE3;
  s_wr_en_4 <= decoder(3) AND WE3;
  s_wr_en_5 <= decoder(4) AND WE3;
  s_wr_en_6 <= decoder(5) AND WE3;
  s_wr_en_7 <= decoder(6) AND WE3;

  RD1 <= s_reg_0 WHEN A1 = "000" ELSE
    s_reg_1 WHEN A1 = "001" ELSE
    s_reg_2 WHEN A1 = "010" ELSE
    s_reg_3 WHEN A1 = "011" ELSE
    s_reg_4 WHEN A1 = "100" ELSE
    s_reg_5 WHEN A1 = "101" ELSE
    s_reg_6 WHEN A1 = "110" ELSE
    s_reg_7 WHEN A1 = "111" ELSE
    "0000000000000000";

  RD2 <= s_reg_0 WHEN A2 = "000" ELSE
    s_reg_1 WHEN A2 = "001" ELSE
    s_reg_2 WHEN A2 = "010" ELSE
    s_reg_3 WHEN A2 = "011" ELSE
    s_reg_4 WHEN A2 = "100" ELSE
    s_reg_5 WHEN A2 = "101" ELSE
    s_reg_6 WHEN A2 = "110" ELSE
    s_reg_7 WHEN A2 = "111" ELSE
    "0000000000000000";

END ARCHITECTURE;