# Introduction to SystemVerilog, FPGA, EDA, and 16-bit Adders

In this experiment you will transition from the TTL physical logic elements to RTL design on FPGA using **SystemVerilog**. 

You will understand the basic syntax and constructs of the **SystemVerilog**, as well as the basic skill required to operate Quartus Prime, a EDA tool for FPGA synthesis and simulation. 

You will also learn the relevant performance analysis using Quartus Prime, as well as the basic optimization procedure in Quartus gearing towards area and power. 

Finally, you will implement a 		***carry-ripple adder, a carry-lookahead adder, and a carry-select adder*** in **SystemVerilog**. You will then analyze their performance in terms of area, power, and the maximum operating frequency.

## Assignment

- Download and install [Quartus Prime (18.0)](https://fpgasoftware.intel.com/?edition=lite) (only available for Windows and Linux) if you decide to work on your own machine. Note that you should install **Quartus Prime Lite Edition**, **Device Support for Cyclone IV**, and **ModelSim Intel FPGA Edition** (**includes Starter Edition, please select Lite Edition during the setup**). 18.0 is the recommended version. If you have a Mac, you should install Windows 10 through Boot Camp (available free of charge for engineering students from the University Webstore) or use Parallels Desktop (available for a fee from the Webstore). 
- Read the [Introduction to SystemVerilog (pdf)](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361044_1/xid-1361044_1) (**UPDATED: 09/10/18**) and the [Experiment 4 section of the lab manual (pdf)](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361045_1/xid-1361045_1) (**UPDATED: 09/10/18**). 
- Read and complete the tutorials in [Introduction to Quartus Prime in the lab manual.](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361046_1/xid-1361046_1) (**UPDATED: 09/10/18**)
- Check out the [Quartus II Tutorial Video](https://mediaspace.illinois.edu/media/t/1_f3qw1xtv) (a video version of the Introduction to Quartus Prime document in the lab manual. A 16-bit ripple adder is implemented step by step in this video.) (**UPDATED: 09/15/17).**
- Check out the [Modelsim/Testbenches intro video](https://learn.intl.zju.edu.cn/webapps/blackboard/content/contentWrapper.jsp?content_id=_101280_1&displayName=Linked+File&navItem=content&attachment=true&course_id=_3009_1&tab_group=courses&href=https%3A%2F%2Fmediaspace.illinois.edu%2Fmedia%2FSystemVerilog%2BTutorialA%2BIntro%2Bto%2BModelsim%2Band%2BBasic%2BTest%2BBenches%2F1_cinisfpy)
- **Complete the 8-bit serial processor exercise in IQT using the provided [logic processor files (zip download)](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361047_1/xid-1361047_1) ,** extending the 4-bit logic processor to an 8-bit version, and confirming that the simulation for your demo (test-bench for 8-bit processor is included)
- Read the Lab 4 description in the lab manual and complete the Lab 4 Pre-Lab and design before the lab section.
- **Design the three adders described in the lab manual by modifying the [provided code (zip download)](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361048_1/xid-1361048_1) .**
- Work on Lab 4 report and Lab 5 Pre-Lab after the lab section.
- (Optionally for your reference) Look at the [tutorial on using schematic capture in Quartus](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361049_1/xid-1361049_1) (not the recommended method in ECE 385)
- (Optionally for your reference) [Modelsim quick reference for .do files](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361050_1/xid-1361050_1) for generating the waveforms in ModelSim. The do files enable you to add the signals and configure the waveform properties easily. However, for the "force" part of the do files, we strongly recommend using tesebenches to achieve it. Refer to IQT page 23 for tutorial about testbenches.
- View the [report outline](https://learn.intl.zju.edu.cn/bbcswebdav/pid-101280-dt-content-rid-1361051_1/xid-1361051_1) for guidelines on writing the report.
- Mirrored Quartus II 18.0 files ([Quartus II 18.0 (Win64)](https://uofi.box.com/s/zbktx8crriqjlam5d44ebss948j026yi), [ModelSim Intel FPGA Edition](https://uofi.box.com/s/zbac959wkp7ha1hqay6kx92bsvj0irh5), [Cyclone IV Support](https://uofi.box.com/s/8y5fxf4vcy7ppw2y963es3ej1qzujk2g))

## Document Updates

- We are trying to make this course better by fixing errors and updating the documents. However, this results in several differences between the latest online version and the printed lab manual. These differences (between the printed 18.1 and online materials) will be noted here:

## Demo

- 1.0 point: Functional simulation completed successfully for the 8-bit serial processor (annotations necessary)
- 1.0 point: RTL block diagram of the 8-bit logic processor extended from 4-bits. This is automatically generated using Quartus (you must demonstrate the generation of this block diagram to your TA from source)
- 1.0 point: Correct operation of the Carry-Ripple Adder on the DE2 board
- 1.0 point: Correct operation of the Carry-Lookahead Adder on the DE2 board using a **4x4 hierarchical design** (TA’s will look at code - note that you **cannot** ripple the 4-bit modules together)
- 1.0 point: Correct operation of the Carry-Select Adder on the DE2 board using a **4x4 hierarchical design** (TA’s will look at code)

## FAQ

- **"I have compiled and tested my code for an 8-bit processor. It works 100% on the DE2 board. However on the simulation, everything seems backwards. When reset is low, the simulation zeroes everything out, when LoadA is 1 it loads into B. However, on the DE2, it works perfectly fine"**

- - The FPGA buttons are active low. That is, a push is recognized as a '0' and doing nothing is recognized as a '1'. The code for the the exercise has inverted the signals for you so that's why it works on the board.  You just have to flip the signals so '1' means it's a push.

- "How should the block diagram be made in SystemVerilog?"

  - From Quartus you can generate a block diagram through 'Tools -> Netlist Viewers -> RTL Viewer'. Verify that you can identify the major modules and their interconnections, and that the block diagram is legible and sensible. Show the process of generating this diagram to your TA for a demo point.

- "The lab asks for an annotated design simulation in the report, what exactly are we supposed to be annotating/pointing out in the simulation? Is there an easy way to do this in Quartus?"

  - That means you'll have to create your own waveform and put comments on the simulated results. "Annotation" means you need to tell us what's going on in each step of the waveform. That is, you need to put comments along the simulation saying what's going on in the particular locations (e.g. here's the value for A... here's the value for B... Here we're adding A and B.... here's the result of A+B... here we're hitting "execute"... here we move to state x... here we're doing this in state x... and so on in the waveform)

- "Also for the state machine can we simply use the one provided by Tools->Netlist Viewers->State Machine Viewer"

  - Yes.  It will show the state flow with 'A'->...->'J' as state representations (since that's how you defined it). However, you will need to explicitly write out what each state is (e.g. Reset->Shift 1->Shift 2->...->Halt) like a regular state machine, so other people can clearly see what's going on. The bottom line is, you'll have to make your state machine understandable standalone.  You could also sketch your own state machine if you wish to.

- "Should the carry-select adder and carry-lookahead adder be made of 16, 1bit adders or made of 4, 4bit adders?"

  - They should be made in 4-bit components, since flat versions are very inefficient.  Demo points will not be given for flat design!

- "I'm getting a licensing error for ModelSim when I try to simulate the test-bench in the tutorial."

  - ModelSim defaults to using the licensed version when launched from Quartus. You can fix this by:
    1. Selecting the tools dropdown menu
    2. Choosing Options..
    3. Selecting EDA Tool options
    4. Changing the line that reads c:\altera\15.0\modelsim_**ae**\win32aloem to read c:\altera\15.0\modelsim_**ase**\win32aloem (add the s)**
       **
    5. **On 18.0, ModelSim is installed by default under c:\intelFPGA_lite\18.0\modelsim_ase\win32aloem**

- "I get the error message 'Illegal reference to net XXX' in ModelSim, how should I fix it?"

  - ModelSim requires all output signals to have their datatypes explicitly declared. Hence, simply replace "**output [3:0] XXX**" with "**output logic [3:0] XXX**" at the interface of the module and the error message will go away.

- "When setting the value (forcing) signals in ModelSim using the GUI Wave Editor (as in IQT.8), the waveform for the forced signals appears incorrect (inconsistent with values, or change/glitch as you scroll) -  though the simulation output is correct."

  - As far as we understand, this is a bug in ModelSim's wave editor, likely because very few users use the GUI tools to set test stimuli. Instead, use a SystemVerilog test bench, as described in the tutorial video(s) and the included example testbench for the 8-bit logic processor.