---------------------------------------------------------------------------------- 
-- Engineer: Arsalan Dabbagh
-- 
-- Create Date: 03/01/2025 
-- Module Name: tb_bclk_gen 
-- Project Name: baud_generator
-- Description: 
-- Testbench for bclk_gen.
-- 
-- Dependencies: 
-- IEEE.STD_LOGIC_1164.ALL
-- IEEE.NUMERIC_STD.ALL; 
--
-- Revision History:
-- Revision 0.01 - File Created
-- 
-- 
-- Additional Comments:
-- 
--
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_bclk_gen is
-- Testbench does not have ports
end tb_bclk_gen;

architecture Behavioral of tb_bclk_gen is

    -- Component Declaration for the Unit Under Test (UUT)
    component bclk_gen
        generic(
            BAUD_RATE           : integer := 115200;
            CLOCK_FREQUENCY     : integer := 100000000;
            OVERSAMPLING_RATE   : integer := 16
        );
        port (
            CLK  : in std_logic;
            RST  : in std_logic;
            BCLK : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal CLK   : std_logic := '0';
    signal RST   : std_logic := '0';
    signal BCLK  : std_logic;

    -- Clock period for 100 MHz clock
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: bclk_gen
        port map (
            CLK => CLK,
            RST => RST,
            BCLK => BCLK
        );

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Apply reset
        RST <= '0';
        wait for 50 us;
        RST <= '1';

        wait;
    end process;

end Behavioral;