# Baud Clock Generator (`bclk_gen`) in VHDL

## Overview
This project implements a **baud clock generator** in VHDL. The module generates a baud clock (`BCLK`) based on the specified baud rate, input clock frequency, and oversampling rate. It includes a testbench to validate the design functionality.

## Features
- Generates a baud clock signal with a user-defined baud rate.
- Supports configurable oversampling rates for precise timing.
- Includes a reset functionality to initialize the clock counter.
- Testbench for functional verification of the design.

## File Structure
```
.
├── bclk_gen.vhd         # VHDL source code for the baud clock generator
├── bclk_gen_tb.vhd      # Testbench for the baud clock generator
├── README.md            # Documentation file
```

## VHDL Module Description
### `bclk_gen`
The `bclk_gen` module generates the baud clock (`BCLK`) signal using an input clock (`CLK`) and reset (`RST`). The clock generation logic uses a counter to divide the input clock frequency based on the desired baud rate and oversampling rate.

### Generic Parameters
| Parameter           | Type    | Default Value | Description                                   |
|---------------------|---------|---------------|-----------------------------------------------|
| `BAUD_RATE`         | Integer | `115200`      | Desired baud rate in bits per second.         |
| `CLOCK_FREQUENCY`   | Integer | `100000000`   | Frequency of the input clock in Hz.           |
| `OVERSAMPLING_RATE` | Integer | `16`          | Oversampling factor for clock generation.     |

### Ports
| Port Name  | Direction | Type       | Description                                   |
|------------|-----------|------------|-----------------------------------------------|
| `CLK`      | Input     | `std_logic`| Input clock signal.                           |
| `RST`      | Input     | `std_logic`| Reset signal. Active-low (`RST = '0'`).       |
| `BCLK`     | Output    | `std_logic`| Generated baud clock signal.                  |

### Functionality
- **Clock Divider:** Divides the input clock frequency to match the required baud rate and oversampling rate.
- **Reset Logic:** Initializes the clock counter and output signal when the reset signal is active.
- **Toggle Signal:** Toggles the output baud clock (`BCLK`) when the counter reaches the maximum count.

## Testbench Description
The testbench (`bclk_gen_tb.vhd`) validates the functionality of the `bclk_gen` module by simulating various input conditions.

### Features
- Tests the reset functionality.
- Verifies the correct toggling of the `BCLK` signal.

### Testbench Structure
1. **Clock Generation:** Simulates the input clock signal (`CLK`).
2. **Stimulus Application:** Applies different reset conditions and monitors the output.

## How to Use
### Prerequisites
- VHDL simulator (e.g., ModelSim, XSIM, or GHDL).

## Customization
- **Adjust Baud Rate:** Modify the `BAUD_RATE` generic parameter in the entity to set a different baud rate.
- **Change Oversampling Rate:** Update the `OVERSAMPLING_RATE` parameter for different oversampling requirements.

## Example Configuration
### Default Settings
- `BAUD_RATE = 115200`
- `CLOCK_FREQUENCY = 100 MHz`
- `OVERSAMPLING_RATE = 16`

### Expected Behavior
- The `BCLK` signal toggles at intervals determined by the baud rate and oversampling rate.
- The reset initializes the counter and output signal to their default states.

## License
This project is licensed under the CERN Open Hardware License Version 2 - Permissive. See the [LICENSE](LICENSE) file for details.

## Contributions
Contributions are welcome! If you find any issues or have suggestions for improvement, please create an issue or submit a pull request.
