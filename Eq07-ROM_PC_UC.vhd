-- Gustavo Schaefer - 2137402
-- Leonardo Braga Cristo - 1561111

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ROM_PC_UC IS
    PORT (
        clkRPU : IN STD_LOGIC;
        rstRPU : IN STD_LOGIC;
        pcRPU : OUT unsigned (6 DOWNTO 0);
        romRPU : OUT unsigned (7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_ROM_PC_UC OF ROM_PC_UC IS

    COMPONENT rom
        PORT (
            clkROM : IN STD_LOGIC;
            addrROM : IN unsigned (6 DOWNTO 0) := "0000000"; -- o PC é 7 ou 16 bits?
            dataROM : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
        );
    END COMPONENT;

    COMPONENT pc
        PORT (
            clkPC : IN STD_LOGIC;
            rstPC : IN STD_LOGIC;
            wr_en_PC : IN STD_LOGIC;
            data_in_PC : IN unsigned (15 DOWNTO 0) := "0000000000000000";
            data_out_PC : OUT unsigned (15 DOWNTO 0) := "0000000000000000"
        );
    END COMPONENT;

    COMPONENT uc
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
    END COMPONENT;

    COMPONENT ULARegs IS
        PORT (
            clock, reset, we3, selecaoMUX : IN STD_LOGIC;
            a1, a2, a3 : IN unsigned (2 DOWNTO 0) := "000";
            operacao : IN unsigned (1 DOWNTO 0) := "00";
            constante : IN unsigned (15 DOWNTO 0) := "0000000000000000";
            out_flagZ : OUT STD_LOGIC;
            out_flag : OUT STD_LOGIC
        );
    END COMPONENT;

    -- sinais do PC
    SIGNAL s_data_in_pc : unsigned(15 DOWNTO 0) := "0000000000000001";
    SIGNAL s_data_out_pc : unsigned(15 DOWNTO 0) := "0000000000000000";

    -- sinais da ROM
    SIGNAL s_dado_rom : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL s_endereco_rom : unsigned(6 DOWNTO 0) := "0000000";

    -- sinais da UC
    SIGNAL s_opcode_uc : unsigned(4 DOWNTO 0) := "00000";
    SIGNAL s_estado_uc : unsigned(1 DOWNTO 0) := "00";
    SIGNAL s_jump_en_uc : STD_LOGIC := '0';
    SIGNAL s_pc_we : STD_LOGIC := '0';
    SIGNAL s_reg_we : STD_LOGIC := '0';
    SIGNAL s_op_ULA : unsigned(1 DOWNTO 0) := "00";
    SIGNAL s_constante_en : STD_LOGIC := '0';

    -- sinais do ULARegs
    SIGNAL s_in_A1 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL s_in_A2 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL s_in_A3 : unsigned(2 DOWNTO 0) := "000";
    SIGNAL s_constante_ext : unsigned(15 DOWNTO 0) := "0000000000000000";
    SIGNAL s_out_flagZ : STD_LOGIC := '0'; -- flag para indicar resultado 0
    SIGNAL s_out_flag : STD_LOGIC := '0'; -- flag de comparação

BEGIN

    ROM_1 : rom PORT MAP(
        clkROM => clkRPU,
        addrROM => s_endereco_rom,
        dataROM => s_dado_rom
    );

    P_C : pc PORT MAP(
        clkPC => clkRPU,
        rstPC => rstRPU,
        wr_en_PC => s_pc_we,
        data_in_PC => s_data_in_pc,
        data_out_PC => s_data_out_pc
    );

    U_C : uc PORT MAP(
        clkUC => clkRPU,
        rstUC => rstRPU,
        instUC => s_dado_rom,
        jump_en_UC => s_jump_en_uc,
        pcWE_UC => s_pc_we,
        regWE => s_reg_we,
        op_ULA => s_op_ULA,
        const_en => s_constante_en,
        stateUC => s_estado_uc
    );

    ULA_Regs : ULARegs PORT MAP(
        a1 => s_in_A1,
        a2 => s_in_A2,
        a3 => s_in_A3,
        we3 => s_reg_we,
        clock => clkRPU,
        reset => rstRPU,
        operacao => s_op_ULA,
        constante => s_constante_ext,
        selecaoMUX => s_constante_en,
        out_flagZ => s_out_flagZ,
        out_flag => s_out_flag
    );

    s_constante_ext <= "0000000000000" & s_dado_rom(2 DOWNTO 0);

    s_in_A3 <= s_dado_rom(10 DOWNTO 8); -- registrador de destino
    s_in_A2 <= s_dado_rom(2 DOWNTO 0); -- registrador, operando 2
    s_in_A1 <= s_dado_rom(5 DOWNTO 3); -- registrador, operando 1

    s_endereco_rom <= s_data_out_pc(6 DOWNTO 0) WHEN s_estado_uc = "10" ELSE
        s_endereco_rom;

    s_data_in_pc <= s_data_out_pc + "0000000000000001" WHEN s_jump_en_uc = '0' ELSE
        s_data_out_pc(15 DOWNTO 9) & "00" & s_dado_rom(6 DOWNTO 0) WHEN s_jump_en_uc = '1';

END a_ROM_PC_UC;