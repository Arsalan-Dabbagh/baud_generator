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
        BAUD_RATE           : 	integer := 9600; 		-- Desire baud rate
        CLOCK_FREQUENCY     : 	integer := 100000000;	-- Input clock in Hz
		OVERSAMPLING_RATE	: 	integer := 16			-- Oversampling rate for the clock
    );
	
    Port (
        IN_CLK  : in std_logic;		-- Input clock signal
        B_CLK   : out std_logic 	-- Output baud clock signal
     );
	 
end bclk_gen;
    
architecture Behavioral of bclk_gen is
    
    constant COUNTER_MAX : integer := CLOCK_FREQUENCY / (BAUD_RATE * OVERSAMPLING_RATE); -- Maximum counter to achieve the desired baud rate
    
    signal clock_counter : integer := 0;	-- Internal signal to count the clock
    
    signal bclk_reg	: std_logic := '0';		-- Register to hold state of the baud clock
    
begin
	-- Process to generate the baud clock
    baud_process: process(IN_CLK) 
        begin
            if rising_edge(IN_CLK) then 	-- Triggered on the rising edge 
                if clock_counter = COUNTER_MAX - 1 then
					clock_counter <= 0;
                    bclk_reg <= not bclk_reg; 	-- Toggle the baud clock
				else
                    clock_counter <= clock_counter + 1;
                end if;
            end if;
        end process; 
     
    B_CLK <= bclk_reg;	-- Assign the baud register to the output port   

end Behavioral;
