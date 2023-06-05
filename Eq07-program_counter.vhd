-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clkPC : IN STD_LOGIC;
        rstPC : IN STD_LOGIC;
        wr_en_PC : IN STD_LOGIC;
        data_in_PC : IN unsigned (15 DOWNTO 0) := "0000000000000000";
        data_out_PC : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
    );
END ENTITY;

ARCHITECTURE a_pc OF pc IS
    COMPONENT reg16bits
        PORT (
            clkREG, rstREG, wr_en_REG : IN STD_LOGIC;
            data_in_REG : IN unsigned(15 DOWNTO 0) := "0000000000000000";
            data_out_REG : OUT unsigned(15 DOWNTO 0) := "0000000000000000"
        );
    END COMPONENT;

BEGIN

    pc : reg16bits PORT MAP(
        clkREG => clkPC,
        rstREG => rstPC,
        wr_en_REG => wr_en_PC,
        data_in_REG => data_in_PC,
        data_out_REG => data_out_PC
    );

END a_pc;