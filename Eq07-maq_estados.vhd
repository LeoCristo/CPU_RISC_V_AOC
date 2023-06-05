-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY stMach IS
    PORT (
        clkSM : IN STD_LOGIC;
        rstSM : IN STD_LOGIC;
        stateSM : OUT unsigned (1 DOWNTO 0) := "00"
    );
END ENTITY;

ARCHITECTURE a_stMach OF stMach IS
    SIGNAL state : unsigned (1 DOWNTO 0) := "00";

BEGIN

    PROCESS (clkSM, rstSM)
    BEGIN
        IF rstSM = '1' THEN
            state <= "00";
        ELSIF rising_edge(clkSM) THEN
            IF state = "10" THEN
                state <= "00";
            ELSE
                state <= state + 1;
            END IF;
        END IF;
    END PROCESS;

    stateSM <= state;

END a_stMach;