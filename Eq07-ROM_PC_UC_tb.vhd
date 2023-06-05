-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ROM_PC_UC_tb IS
END ENTITY;

ARCHITECTURE a_ROM_PC_UC_tb OF ROM_PC_UC_tb IS
    COMPONENT ROM_PC_UC
        PORT (
            clkRPU : IN STD_LOGIC;
            rstRPU : IN STD_LOGIC;
            pcRPU : OUT unsigned (6 DOWNTO 0);
            romRPU : OUT unsigned (7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC;
    SIGNAL rst : STD_LOGIC := '1';

BEGIN
    processador : ROM_PC_UC PORT MAP(
        clkRPU => clk,
        rstRPU => rst
    );

    -- clock do sistema

    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 50 ns;
        clk <= '1';
        WAIT FOR 50 ns;
    END PROCESS;

    -- clock do sistema

    PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 50 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

END a_ROM_PC_UC_tb;