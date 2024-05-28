# Idea & Resource



1. Pong Game with Code

   https://www.fpga4fun.com/PongGame.html

2. DE2 115 Board 资料

   https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=502&PartNo=4#

3. [每日一问](https://www.terasic.com.tw/wiki/DE2-115%E6%AF%8F%E6%97%A5%E4%B8%80%E9%97%AE)

4. Find a workable FPGA code for Tetris 

5. 以前的ZJUI大爹

   https://lantian.pub/article/modify-computer/cyclone-iv-fpga-development-bugs-resolve.lantian/



## FPGA - Tetris Game Reference 

1. Verilog HDL高级数字设计

   实验报告

   题目：“俄罗斯方块”FPGA实现

   https://blog.csdn.net/weixin_44830487/article/details/115972133

2. tetris game on FPGA

   https://github.com/hanchenye/FPGA-tetris?tab=readme-ov-file

3. VGA standard timing

   http://tinyvga.com/vga-timing/640x480@60Hz

4. 









### 6. Challenges and Solutions

#### 6.1 Technical Challenges

**Extra Long Compilation Time:** The final game version required 27.21 minutes for a full compilation, primarily due to the music module and background image rendering. This prolonged compilation time posed significant difficulties during debugging.

![Fig: It took nearly half an hour to compile one run, extremely painful for debugging. Acceleration and task segmentation is very necessary for FPGA programming.](image.png)

**Solutions Implemented:**
- **Incremental Compilation:** Compiled only modified portions of the design to reduce subsequent compilation times.
- **Task Segmentation:** Divided the design into smaller, manageable modules for independent testing and validation.
- **Optimized Synthesis Settings:** Fine-tuned synthesis and placement settings in Quartus Prime for efficient resource utilization.
- **Parallel Processing:** Utilized maximum available processors for parallel processing to speed up compilation.

These strategies effectively mitigated the impact of long compilation times, enhancing productivity and efficiency in the FPGA-based Tetris game development.
