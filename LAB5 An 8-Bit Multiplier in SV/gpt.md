4.1
ECE 385
EXPERIMENT #4
Introduction to SystemVerilog, FPGA, CAD, and 16-bit Adders
I. OBJECTIVE
In this experiment you will transition from breadboard TTL (transistor-transistor logic)
elements to RTL (register-transfer level) design on an FPGA using SystemVerilog. You will come
to understand the basic syntax and constructs of SystemVerilog, as well as acquire the basic skill
required to operate Quartus Prime, a CAD tool for FPGA synthesis and simulation. Quartus
Prime’s performance analysis and optimization tools will be explored in the process of
implementing three types of adders: a carry-ripple adder, a carry-lookahead adder, and a carryselect adder. This performance analysis and optimization will look at the various adders’ area,
power, and maximum operating frequencies.
II. INTRODUCTION
Please read the INTRODUCTION TO SYSTEMVERILOG AND TUTORIAL (IST. 1-26)
and the INTRODUCTION TO QUARTUS PRIME (IQT. 1-40).
In addition to the standard synthesis and simulation capability, Quartus Prime provides a
variety of compiler settings for the designer to tweak for the synthesis and compilation process.
Depending on the settings the designer can gear the generated circuit to comply with some
predefined constraints or performance criteria, such as the maximum operating frequency of the
circuit, the maximum area of the circuit layout, or the maximum static or dynamic power consumed
by the circuit.
During the synthesis and compilation process, Quartus Prime collects a variety of analysis
data and display them in the generated Compilation Report. These data are important to the
designer in the sense that the designer relies on these data to determine if his or her circuit has met
the performance constraints. If the analysis result is far off from the performance criteria, the
designer will most likely have to modify the circuit from the designing aspect of the circuit. On
the other hand, if the analysis result is just slightly below the performance criteria, then the designer
can use many of the built-in tools to optimize the circuit during the compilation process to meet
the performance criteria.
4.2
Quartus Prime offers a variety of optimization tools, such as TimeQuest Timing Analyzer
for the timing constraint, PowerPlay Power Analyzer for the power constraint, and a built-in
placement fitter for the area constraint. Many of the optimization steps can be done by simply
changing the various synthesis and compilation settings, as suggested by the Quartus Prime
Optimization Advisors, some of the in-depth optimization and analysis can only be done by
providing specific constraints to the analyzers.
In most industry practices, circuit implementation on FPGA is usually only a small portion
of the entire design, where the circuit on FPGA will interface with external circuits through its
inputs and outputs. These external circuits will have their own performance constraints which the
FPGA circuit has to follow in order to be integrated. To incorporate these external constraints into
the FPGA design, they are written into constraint files such as the Synopsys Design Constraint
(SDC) format as input to the Quartus Prime Analyzers, where the analyzers will then be able to
analyze and optimize the circuit based on the provided constraints.
To read more about the optimization process in Quartus Prime, please refer to Section III
in Volume 2 of the Quartus Prime Standard Edition Handbook (currently v18.0, accessible on the
Intel FPGA website) Chapter 10 gives a design optimization overview, Chapter 12-14 discuss
timing, power and area optimization, respectively.
Binary adders are a key component of logic circuits. They are used not only in the
arithmetic logic units (ALU) for data processing but are also used in other parts of a logic processor
to calculate addresses and signal evaluations. An N-bit binary adder takes two binary numbers (A
and B) of size N and a carry-in (Cin) as inputs, sum up the three values, and produces a sum (S)
and a carry-out (Cout), as shown in Figure 1.
Figure 1: N-bit Binary Adder Block Diagram
Among the many different binary adder designs, the most straightforward one is the CarryRipple Adder (CRA). It is constructed using N full-adders. A full-adder is a single-bit version of
the binary adder, where three binary bits (A, B and Cin) are inputted through a set of logic gates to
produce a single-bit sum (S) and a single-bit carry-out (Cout), as shown in Figure 2. The N fulladders are then linked together in series through the carry bits, forming an N-bit binary adder.
A<N-1:0> B<N-1:0>
Sum<N-1:0>
Cout adderN Cin
4.3
When the binary inputs are provided, the full-adder of the least significant bit (LSB) will produce
a sum (S0) and a carry-out (C1). The carry-out is fed to the carry-in of the second full-adder, which
then produces a second sum (S1) and a second carry-out (C2). The process ripples through all N
bits of the adder as shown in Figure 3, and settles when the full-adder of the most significant bit
(MSB) outputs its sum (SN-1) and carry-out (Cout).
Figure 2: Full-Adder Block Diagram
Figure 3: N-bit Carry-Ripple Adder Block Diagram
The CRA is simple in the design and straightforward to implement, but the long
computation time is its drawback. Every full-adder has to wait for their lower-bit neighbor to
produce a carry-out before it can correctly compute its sum and carry-out. This means that the
propagation delay of the CRA increases with N. If one wishes to reduce the computation time, it
is apparent that the computation of the carry-out bits has to be somehow parallelized. And this is
precisely how a carry-lookahead adder operates.
Instead of waiting on the actual carry-in values, Carry-Lookahead Adder (CLA) uses the
concept of generating (G) and propagating (P) logic. The concept is that every bit of the CLA
x y
s
c z
full_
adder
x
s
c
y
z
x y
c z
x y
FA1 c FA0 z
A1 B1 A0 B0
Cout Cin
C1
S1 S0
C2
x y
c FAN-1 z
AN-1 BN-1
CN-1
SN-1
…
s s s
4.4
makes predictions using its immediate available inputs (A and B), and predicts what its carry-out
would be for any value of its carry-in. A carry-out is generated (G) if and only if both available
inputs (A and B) are 1, regardless of the carry-in. The equation is 𝐺(𝐴, 𝐵) = 𝐴 ⋅ 𝐵. On the other
hand, a carry-out has the possibility of being propagated (P) if either A or B is 1, which is written
as 𝑃(𝐴, 𝐵) = 𝐴 ⊕ 𝐵. With P and G defined, the Boolean expression for the carry-out
Ci+1giving
a potential
Ci
is then 𝐶𝑖+1 = 𝐺𝑖 + (𝑃𝑖
⋅ 𝐶𝑖
). Notice that
Ci+1
can be expressed in terms of
which in turn can be expressed in terms of
Ci−1 . However, if still depends on
Ci−1, it will
behave like a ripple adder without giving any gain in speed. Therefore, to avoid the slow rippling
of the carry bits, the expression of should be expanded and computed directly from
Pi
s,
Gi
s.
For example,
𝐶0 = 𝐶𝑖𝑛
𝐶1 = 𝐶𝑖𝑛 ⋅ 𝑃0 + 𝐺0
𝐶2 = 𝐶𝑖𝑛 ⋅ 𝑃0 ⋅ 𝑃1 + 𝐺0 ⋅ 𝑃1 + 𝐺1
𝐶3 = 𝐶𝑖𝑛 ⋅ 𝑃0 ⋅ 𝑃1 ⋅ 𝑃2 + 𝐺0 ⋅ 𝑃1 ⋅ 𝑃2 + 𝐺1 ⋅ 𝑃2 + 𝐺2
…
In this way, the computation time of the CLA is much faster than that of the CRA, resulting in a
higher operating frequency. The downside of the CLA is its additional logic gates, which
increases both the area and power consumption of the adder.
Figure 4: N-bit Carry-Lookahead Adder Block Diagram
To build an arbitrarily long N-bit CLA, one might be tempted to directly follow the above
‘flat’ approach. However, from the explicit expansion of , you can find that the number of gates
involved for an increasing N will soon grow too large for the CLA to be practical. And thus, it is
Ci Ci Ci
Ci
x y
c z
x y
FA1 c FA0 z
A1 B1 A0 B0
Cin
Cout
S1 S0
x y
C1
c FAN-1 z
AN-1 BN-1
CN-1
SN-1
…
N-bit Carry-Lookahead Unit
s p g s p g s p g
PN-1 GN-1 C2 P1 G1 P0 G0
PG GG
4.5
a common practice to first construct 4-bit CLAs, then use them to create a larger CLA in a
hierarchical fashion. In this lab, the CLA should be implemented in 4x4-bit instead of 16-bit.
In the 4x4-bit hierarchical CLA design, the 16-bit inputs A and B are divided into groups
of 4 bits. First, each group of 4 bits go through a 4-bit CLA, which is illustrated by Figure 4 with
N=4. Note that the 4-bit CLA generates two additional output signals, the group propagate (PG)
and the group generate (GG), with their logics being:
𝑃𝐺 = 𝑃0 ⋅ 𝑃1 ⋅ 𝑃2 ⋅ 𝑃3
𝐺𝐺 = 𝐺3 + 𝐺2 ⋅ 𝑃3 + 𝐺1 ⋅ 𝑃3 ⋅ 𝑃2 + 𝐺0 ⋅ 𝑃3 ⋅ 𝑃2 ⋅ 𝑃1
We will denote the PGs and GGs from these four 4-bit CLAs as PG0, PG4, PG8, PG12, and GG0, GG4,
GG8, GG12 from this point on.
Next, a tempting design is to cascade the four 4-bit CLAs by connecting the Cout from the
previous 4-bit CLA to the Cin of the next 4-bit CLA, but in this way we will be trapped by the
slow rippling of these carry bits again. Therefore, instead of using the Coutfrom the previous 4-
bit CLA, we should generate the Cins of the 4-bit CLAs using the PGs and GGs, as shown by the
formulas below,
𝐶4 = 𝐺𝐺0 + 𝐶0 ⋅ 𝑃𝐺0
𝐶8 = 𝐺𝐺4 + 𝐺𝐺0 ⋅ 𝑃𝐺4 + 𝐶0 ⋅ 𝑃𝐺0 ⋅ 𝑃𝐺4
𝐶12 = 𝐺𝐺8 + 𝐺𝐺4 ⋅ 𝑃𝐺8 + 𝐺𝐺0 ⋅ 𝑃𝐺8 ⋅ 𝑃𝐺4 + 𝐶0 ⋅ 𝑃𝐺8 ⋅ 𝑃𝐺4 ⋅ 𝑃𝐺0
…
Does this look familiar to you? Observe that this is the same as how we generated the carry bits
within a 4-bit CLA. Therefore, we can directly take a copy of the 4-bit Carry-Lookahead Unit
(CLU, red block in Figure 4) in the 4-bit CLA, but instead of the inputs coming from full adders,
this time the inputs are the PGs and GGs from the 4-bit CLAs at the upper level. Figure 5
illustrates the resulting 4x4-bit hierarchical CLA.
This explains why this design is called hierarchical. If we add another layer to the
hierarchy and use four 4x4-bit hierarchical CLAs and another 4-bit CLU, we can make a 4x4x4-
bit hierarchical CLA, namely a 64-bit adder, without any issue of the slow rippling of the carry
bits!
4.6
Figure 5: A 4x4-bit Hierarchical Carry-Lookahead Adder Block Diagram
Carry-Select Adder (CSA) features another way to speed up the carry computation. It
consists of two full adders (or CRAs if multiple bits are grouped) and a multiplexor. One adder
computes the sum and carry-out based on the assumption that the carry-in is 0, and the other
assumes that the carry-in is 1. In this way, both possible outcomes are pre-computed. Once the real
carry-in arrives, the corresponding sum and carry-out is selected to be delivered to the next stage.
By paying the price of almost twice the numbers of adders, we gain some speedup (how exactly
do we gain this speedup – we will discuss this in lecture, but you should make sure you understand
and explain in your own words for your lab report!)
In this lab, you are going to design a 16-bit CSA with 4x4-bit hierarchical structure as
illustrated by Figure 5. For each group of 4-bit inputs, we use two CRAs to calculate two versions
of the results, one with carry-in bit assumed to be 0 and the other to be 1. Note that the lowest
significant group requires only one CRA, since its carry-in bit is directly available. Therefore,
eventually the 16-bit CSA will contain seven 4-bit CRAs.
+
Cin
A4:1 B4:1
S4:1
C4
+
+
1
0
A8:5 B8:5
S8:5
C8
+
+
1
0
A12:9 B12:9
S12:9
C12
+
+
1
0
A16:13 B16:13
S16:13
Cout
0
1
0
1
0
1
Figure 5: 16-bit Carry-Select Adder Block Diagram
PG0 GG0 PG4 GG4 PG8 GG8 PG12 GG12
4.7
Your circuits should have the following inputs and outputs:
Inputs
Clk, Reset, Load_B, Run – logic
SW – logic [15:0]
Outputs
CO – logic
Sum – logic[15:0]
Ahex0, Ahex1, Ahex2, Ahex3, Bhex0, Bhex1, Bhex2, Bhex3 – logic [6:0]
Internal Registers
A – logic [15:0]
B – logic [15:0]
SW[15:0] should come from on-board switches and its value should be displayed on Ahex0,
Ahex1, Ahex2, and Ahex3 as a four-digit hex number. When Load_B is pressed, the registers
B[15:0] should load the values of SW[15:0] to serve as B, one of the numbers to be added, and
B[15:0] should be displayed on Bhex0, Bhex1, Bhex2, and Bhex3. At other times, the registers
A[15:0] constantly load the values of SW[15:0] which serve as A, the other number to be added.
The value of Sum[15:0] should be displayed on red LEDs (LEDR[15:0]), and CO should be
displayed on LEDG[8] to indicate overflow. When Run is pressed, Sum[15:0] and CO should be
updated with the result of adding SW[15:0] (A) and the old B[15:0] (B). Reset should clear all the
registers. To achieve optimal speed, the CSA will also need to be built in a hierarchical fashion.
In this lab, the CSA should be implemented in 4x4-bit instead of 16-bit.
A test platform is required to demo your adders as there are not enough switches on the
DE2-115 board. This platform is provided in the included Lab 4 files on the website, and it should
be clear where to place your code for the three types of adders you will design. Registers A and B
store the operands to be added, depending on whether Load_B is pressed (register A is
continuously loaded from the switches on every cycle). Upon pressing the ‘Run’ button, the state
machine will load the resulting sum (A+B) into a 16-bit output register to display. The load and
run operation will be executed only once when the Load_B or run button is pressed each time,
respectively. The circuit should be able to run multiple times without resetting the circuit before
each operation.
III. PRE-LAB
A. Complete the bit-serial logic processor exercise from the Introduction to SystemVerilog and
Tutorial (IQT. 1-40). Include a copy of the generated diagram from Quartus of the 8-bit logic
processor and the simulation waveform (with annotations) in your Lab 4 lab report.
4.8
B. Design, document, and implement a 16-bit carry-ripple adder, a 16-bit carry-lookahead adder,
and a 16-bit carry-select adder in SystemVerilog. Use the provided code (from the website) as
a testing framework.
C. Document design analysis for the three adders in the table below. Plot out the data from the
table for comparison studies. Normalize the data across the three adders with the carry-ripple
adder. When normalizing, choose data from one the carry-ripple adder as the baseline, and then
divide the other two with the baseline number. Say, you got 20 from carry-ripple, 21 from
carry-select, and 23 from carry-lookahead, the numbers after normalization becomes
20/20=1.0, 21/20=1.05, 23/20=1.15, respectively. The resulting plot should resemble the one
below (the plot below does not use real data).
Carry-Ripple Carry-Select Carry-Lookahead
Memory (BRAM)
Frequency
Total Power
You will need to bring the following to the lab:
1. Your code for the 8-bit processor in a Quartus Prime project, ready to simulate in
ModelSim. You can bring the code to the lab using a USB storage device, FTP, or any
other method.
2. Your code for the 3, 16-bit adders with a project ready to synthesize and test on the FPGA
board, be prepared to show your TA each adder’s code to verify they are indeed performing
according to design.
3. A block diagram for the 8-bit processor (or a project file which will generate the block
diagram) to verify that you have completed the tutorial.
4.9
Demo Points Breakdown:
1.0 point: Functional simulation completed successfully for the 8-bit serial processor (annotations
necessary)
1.0 point: RTL block diagram of the 8-bit logic processor extended from 4-bits. This can be
automatically generated using Quartus.
1.0 point: Correct operation of the Carry-Ripple Adder on the DE2 board
1.0 point: Correct operation of the Carry-Lookahead Adder on the DE2 board using a 4x4
hierarchical design 
1.0 point: Correct operation of the Carry-Select Adder on the DE2 board using a 4x4 hierarchical
design 
