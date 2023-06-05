-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY uc IS
    PORT (
        clkUC : IN STD_LOGIC;
        rstUC : IN STD_LOGIC;
        instUC : IN unsigned (15 DOWNTO 0) := "0000000000000000";
        jump_en_UC : OUT STD_LOGIC;
        pcWE_UC : OUT STD_LOGIC;
        regWE : OUT STD_LOGIC;
        op_ULA : OUT unsigned(1 DOWNTO 0) := "00";
        const_en : OUT STD_LOGIC;
        stateUC : OUT unsigned(1 DOWNTO 0) := "00"
    );
END ENTITY;

ARCHITECTURE a_uc OF uc IS

    COMPONENT stMach
        PORT (
            clkSM : IN STD_LOGIC;
            rstSM : IN STD_LOGIC;
            stateSM : OUT unsigned (1 DOWNTO 0) := "00"
        );
    END COMPONENT;

    SIGNAL state : unsigned (1 DOWNTO 0) := "00";
    SIGNAL opCode : unsigned (3 DOWNTO 0) := "0000";

BEGIN
    stateMachine : stMach PORT MAP(
        clkSM => clkUC,
        rstSM => rstUC,
        stateSM => state
    );

    opCode <= instUC (15 DOWNTO 12);

    jump_en_UC <= '1' WHEN opCode = "0001" ELSE
        '0';

    pcWE_UC <= '1' WHEN state = "00" ELSE
        '0';

    regWE <= '1' WHEN (state = "01" AND (opCode = "0111" OR opCode = "0011"
        OR opCode = "0100" OR opCode = "1110")) ELSE
        '0';

    op_ULA <= "00" WHEN opCode = "0111" ELSE -- add
        "00" WHEN opCode = "0011" ELSE -- addi
        "01" WHEN opCode = "0100" ELSE -- subi
        "10" WHEN opCode = "1110" ELSE -- div
        "00"; -- others

    const_en <= '1' WHEN opCode = "0011" ELSE -- addi
        '1' WHEN opCode = "0100" ELSE -- subi
        '1' WHEN opCode = "1110" ELSE -- div
        '0'; -- others

    stateUC <= state;

END a_uc;