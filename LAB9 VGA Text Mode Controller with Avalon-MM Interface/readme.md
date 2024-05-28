## Lab 9 Guide: VGA Text Mode Controller with Avalon-MM Interface

*Code of lab 9 is too messy so we don't include them here.*

> Here's a step-by-step guide to help you navigate through Lab 9 of ECE 385, focusing on the development of a text mode VGA controller using an Avalon-MM interface. 

### Step 1: Understand the Lab Objectives and Requirements
- **Read the Lab Manual**: Begin by thoroughly reading the lab documentation provided, focusing on understanding the objective of creating a text mode VGA controller that outputs 80 columns of text through VGA.
- **Review Previous Labs**: Refresh your knowledge of the VGA interface and Avalon memory-mapped (Avalon-MM) bus from previous labs, particularly the basic VGA output and interface connections.

### Step 2: Set Up Your Working Environment
- **Gather Required Software and Hardware**: Ensure you have access to Quartus Prime, ModelSim, and the FPGA development board (e.g., Altera Cyclone IV).
- **Prepare Initial Files**: Start with your design files from Lab 8, including any VGA controller and color mapper modules you might have used.

### Step 3: Design the Text Mode VGA Controller
- **Implement the Controller IP**: Create a new IP core for the VGA text mode controller. This will manage the display of text characters from the video RAM (VRAM) through the VGA interface.
  - Use SystemVerilog to define the module that will interact with the Avalon-MM interface for reading from and writing to the VRAM.
  - Design the VRAM layout and character encoding scheme based on the project requirements (e.g., supporting 80x30 text mode).

### Step 4: Integrate with Avalon-MM Interface
- **Modify Platform Designer Setup**: Add your newly created VGA text mode controller to the existing Platform Designer project.
  - Connect the controller to the Avalon-MM bus, ensuring it can communicate with the Nios II processor or any other master component.
  - Define the memory-mapped registers and setup required control signals.

### Step 5: Develop the Display Logic
- **Implement Character Drawing**: Using the VGA output signals (such as horizontal and vertical sync), develop the logic to read character data from VRAM and display it on the VGA monitor.
  - Integrate the font ROM to fetch glyph bitmaps for each character.
  - Handle text attributes like color and inverted display if required by the lab specifications.

### Step 6: Simulation and Testing
- **Simulate the Design**: Use ModelSim to simulate your VGA text mode controller to verify its functionality before deploying it on the hardware.
  - Test the interaction between the Avalon-MM interface and VRAM.
  - Validate the correct display of characters and handling of different text attributes.

### Step 7: Deploy and Debug on Hardware
- **Program the FPGA**: Load your design onto the FPGA board and connect it to a VGA monitor.
- **Run Test Routines**: Use test routines, often provided as C code to run on the Nios II processor, to validate the functionality of your text mode controller in a real-world scenario.
- **Debug and Iterate**: Identify any issues through testing on the hardware and refine your design and code accordingly.

### Step 8: Document Your Work
- **Write the Lab Report**: Document the design process, challenges faced, and solutions implemented. Include diagrams, code snippets, and descriptions of your testing procedures.
- **Review and Reflect**: Evaluate what worked well and what could be improved. Consider how the skills learned could be applied to future projects or extended in your final project.

### Step 9: Submission
- **Finalize Your Report and Code**: Ensure all files are complete and adhere to the submission guidelines provided by your instructor.
- **Submit Your Work**: Provide your lab report and any required design files to your teaching assistant as per the course's submission procedure.

By following these steps, you should be able to successfully complete Lab 9 and gain a solid understanding of creating a VGA text mode controller interfaced with the Avalon-MM bus.