-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY rom IS
    PORT (
        clkROM : IN STD_LOGIC;
        addrROM : IN unsigned (6 DOWNTO 0) := "0000000"; -- o PC é 7 ou 16 bits?
        dataROM : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
    );
END rom;

ARCHITECTURE a_rom OF rom IS

    TYPE mem IS ARRAY (0 TO 127) OF unsigned (15 DOWNTO 0);
    CONSTANT contROM : mem := (
        0 => b"0011_100_000_000100", -- addi R4, x0, 4; opcode (0011) => Carrega R4 com o valor 4
        1 => b"0011_101_000_000110", -- addi R5, x0, 6; opcode (0011) => Carrega R5 com 6
        2 => b"0111_110_100_101_000", -- add R6, R4, R5; opcode (0111) => Soma R4 com R5 e guarda em R6
        3 => b"0100_110_110_000010", -- subi R6, R6, -2; opcode (0011) => Subtrai 2 de R6
        4 => b"0001_000000001111",   -- jal x0, 15; opcode (0001) => Salta para o endereco 15
        5 => b"0111_100_000_110_000", -- add R4, x0, R6; opcode (0111) => No endereco 15, copia R6 para R4
        6 => b"1110_111_110_000011", -- div R7, R6, 3; opcode (1110) => No endereco 15, calcula a divisão de R6 por 3 e guarda em R7
        7 => b"0001_000000000011",   -- jal x0, 3; opcode (0001) -- Salta para a terceira instrucao desta lista (R6 <= R4 + R5)
        OTHERS => (OTHERS => '0')
    );

    SIGNAL s_dataROM : unsigned(15 DOWNTO 0) := "0000000000000000";

BEGIN

    dataROM <= s_dataROM;

    PROCESS (clkROM)
    BEGIN
        IF (rising_edge(clkROM)) THEN
            s_dataROM <= contROM(to_integer(addrROM));
        END IF;
    END PROCESS;

END a_rom;