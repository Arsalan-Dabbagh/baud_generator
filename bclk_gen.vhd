---------------------------------------------------------------------------------- 
-- Engineer: Arsalan Dabbagh
-- 
-- Create Date: 03/01/2025 
-- Module Name: bclk_gen 
-- Project Name: baud_generator
-- Description: 
-- Implements a baud rate generator in VHDL.
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
-- The bclk_gen module derives specific baud rates from a given input clock.
-- 
--
-- Licensed under the CERN-OHL-P v2.0.
-- See the LICENSE file or https://cern.ch/cern-ohl-p for detailsS
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;     


entity bclk_gen is

    
    generic(
        BAUD_RATE           : integer := 115200;    -- Desired baud rate
        CLOCK_FREQUENCY     : integer := 100000000; -- Frequency of the input clock in Hz
        OVERSAMPLING_RATE   : integer := 16         -- Oversampling factor
    );
    
    
    port (
        CLK 	: in std_logic;		-- Input clock signal					
        RST		: in std_logic;		-- Asynchronous reset signal
        BCLK	: out std_logic		-- Generated baud clock output				
     );
     
end bclk_gen;


architecture Behavioral of bclk_gen is
	
    -- Calculate the maximum counter value for one baud clock cycle
    constant COUNTER_MAX: integer := CLOCK_FREQUENCY  / (BAUD_RATE * OVERSAMPLING_RATE);
    
    -- Signal of counter value
    signal clock_counter: integer := 0;	
    
    -- Signal of generated baud clock state
    signal baud_reg: std_logic := '0';

begin

    -- Process to generate the baud clock
    baud_process: process(CLK, RST)
    begin
        -- Check for rising edge of the clock
        if rising_edge(CLK) then
            -- If reset is active (RST = '0'), initialize the counter and output signal
            if RST = '0' then
                clock_counter <= 0;
                baud_reg <= '0';
            else
                -- If the counter reaches the maximum value, toggle the baud clock and reset the counter
                if clock_counter = COUNTER_MAX - 1 then
                    clock_counter <= 0;
                    baud_reg <= not baud_reg;  -- Toggle baud_reg
                -- If the counter hasn't reached the maximum, increment it
                elsif clock_counter < COUNTER_MAX - 1 then
                    clock_counter <= clock_counter + 1;
                end if;
            end if;
        end if;
    end process;

    -- Assign the generated baud clock signal to the output port
    BCLK <= baud_reg; 

end Behavioral;
