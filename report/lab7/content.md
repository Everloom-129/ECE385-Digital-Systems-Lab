### Lab Questions and Answers

#### What are the differences between the Nios II/e and Nios II/f CPUs?
The Nios II/e is an economical version of the processor optimized for minimal resource and logic element usage, operating at slower speeds due to a higher clock cycle count per instruction, unlike the faster Nios II/f variant.

#### What advantage might on-chip memory have for program execution?
On-chip memory offers higher access speeds and operates at higher frequencies due to its proximity to the CPU, as opposed to off-chip memory, which has a longer data path and slower access times.

#### Is the Nios II a Von Neumann, "pure Harvard", or "modified Harvard" machine and why?
Nios II is a "modified Harvard" architecture as it has shared memory for instructions and data but employs separate buses for instruction and data transfer, differentiating it from "pure Harvard" and Von Neumann architectures.

#### Why does the LED peripheral only need access to the data bus, unlike on-chip memory?
LED peripherals only require data bus access for displaying data, whereas on-chip memory needs to store both instructions and data, necessitating access to both the data and program bus.

#### Why does SDRAM require constant refreshing?
SDRAM comprises capacitors and transistors that naturally decay over time. Regular refreshing is necessary to maintain data integrity and prevent loss due to charge leakage.









**Maximum Theoretical Transfer Rate to SDRAM:**
Given an access time of 5.5ns and a 32-bit data width, the maximum transfer rate to the SDRAM is 32 bits / 5.5ns, which equals approximately 727MB/s.

**Minimum SDRAM Operating Frequency:**
The SDRAM must maintain a minimum operating frequency of 50 MHz. This is due to the presence of capacitors that require frequent refreshing to retain their voltage level and thus preserve the correctness of the stored data.

**Phase Shift for SDRAM Clock:**
Creating an additional output with a phase shift of -3ns aligns the SDRAM chip clock (clk c1) 3ns ahead of the controller clock (clk c0). This phase shift is crucial as it allows time for the SDRAM controller to stabilize data access and ensures that control signals are valid at the address pins.

**NIOS II Execution Start Address:**
The NIOS II processor begins execution from the SDRAM address x0200 0000. This step is necessary to ensure that the processor starts with the correct instruction sequence and avoids accessing non-instructional memory regions.

**Understanding the Provided Program:**
Each line of the sample program must be understood in detail, particularly the use of the `volatile` keyword (line 8), and the functionality of the set and clear operations (lines 13 and 16). The `volatile` keyword indicates that the value of the object can change at any moment and is typically associated with hardware registers. Using `volatile` for hardware pointers ensures the compiler does not optimize out important reads or writes to those hardware addresses. In lines 13 and 14, the SET operation involves a delay loop and sets the least significant bit of the LED to '1', lighting up the rightmost LED. In lines 15 and 16, the CLEAR function performs a bitwise AND with x0001, effectively clearing the least significant bit and turning off the LED.