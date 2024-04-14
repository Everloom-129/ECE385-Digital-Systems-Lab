# Lab 8 Step by Step Guide

> In Lab 8, you'll interface a keyboard and a monitor with the DE2 board using USB and VGA. This lab involves integration of software and hardware components, focusing on interactive VGA display control using keyboard inputs. Here's how you can approach this lab step by step:

### Step 1: Platform Designer Setup
- **Objective:** Integrate the NIOS II Processor with the CY7C67200 USB chip.
- **Actions:**
  1. Open the Platform Designer in Quartus.
  2. Include the NIOS II processor and configure it for your project needs.
  3. Add the CY7C67200 USB Controller and set it as a host controller.
  4. Define PIOs (Parallel Input/Output) for address, data, read, write, and chip select. Configure these PIOs according to the requirements of the CY7C67200, ensuring you have bidirectional data lines where necessary.

### Step 2: Top Level Entity
- **Objective:** Assemble the SystemVerilog top-level entity integrating all components.
- **Actions:**
  1. Download and examine the provided SystemVerilog files for the ball movement, VGA controller, and color mapper from the course website.
  2. Connect these modules within your top-level SystemVerilog file (`lab8.sv`). Make sure to map all inputs and outputs correctly to the FPGA pins and internal signals.

### Step 3: Hardware I/O Wrapper
- **Objective:** Manage the hardware connections between the NIOS II PIOs and the CY7C67200 chip controls.
- **Actions:**
  1. Implement the `hpi_io_intf.sv` file to handle tri-state buffering for the shared data bus between the NIOS II and the CY7C67200.

### Step 4: I/O Read and Write Functions
- **Objective:** Enable correct communication for reading and writing to the CY7C67200's registers.
- **Actions:**
  1. Review the CY7C67200 datasheet to understand the Host Port Interface (HPI) protocol.
  2. Implement the IO_read and IO_write functions in SystemVerilog or in your NIOS II C code to manipulate the HPI_ADDRESS, HPI_DATA, and other relevant registers.

### Step 5: USB Read and Write Functions
- **Objective:** Handle data transmission to and from the CY7C67200’s RAM using the registers configured in the previous step.
- **Actions:**
  1. Write USBRead and USBWrite functions that utilize your previously created IO_read and IO_write to perform actual data transfer.

### Step 6: Modify the Ball Movement Logic
- **Objective:** Extend the ball’s movement logic to respond to keyboard input for all directions and add bouncing logic.
- **Actions:**
  1. Start with the provided ball movement sample code.
  2. Add conditions and logic to move the ball in both X and Y directions based on keyboard input (W, A, S, D).
  3. Implement edge detection and bouncing behavior for the screen’s borders.

### Lab Execution and Testing
- **Objective:** Integrate and test the complete system.
- **Actions:**
  1. Program the FPGA with your completed design.
  2. Connect a USB keyboard and VGA monitor to the DE2 board.
  3. Test each function starting with simple ball movement, then keyboard control, and finally full functionality including edge bouncing.
  4. Debug any issues by checking connections, logic in code, and FPGA configurations.

### Documentation and Submission
- Prepare a detailed lab report covering your design, the operation of each module, USB and VGA interfaces, and a discussion of your testing and results. Include diagrams and code snippets where appropriate.

Ensure to follow the ECE 385 course guidelines and checklists for FPGA and software development, and utilize debugging tools available in the Quartus software and on your DE2 board to assist in your development process.