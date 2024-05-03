# ECE385 Final Project Proposal

Jie Wang & Shitian Yang

May 3rd, 2024

## Final Project Ideas

Term projects can be on any idea you want to pursue (provided they are approved by the instructor or the TA). The students are encouraged to pick the projects based on their interest. Please keep in mind that it is much better to have a working final project than a challenging proposal that doesn't work. Just to get you thinking about projects ideas, here's a partial list of projects. Your proposal should make clear what is software (C code) and what is hardware (SystemVerilog) in your design. 

- TTL chip checker that checks the integrity of the chips
- Image/Video/Audio encoding and decoding (JPG, MP3, MJPEG, etc...)
- Encryption/Decryption for secure data transmission (e.g. Feistel, real time pipelined AES)
- Any video/arcade game which uses VGA screen and input devices
  - Arcade classics (Frogger, Space Invaders, Joust, Pacman, **Missile Command**)
  - Vertical or Horizontal Shooters
  - Tetris
  - DDR/Beatmania with sound
  - Snake - **not recommended, will have 0 difficulty points unless demo is impressive**
  - Breakout/Brickbreaker - **not recommended, will have 0 difficulty points unless demo is impressive**
  - Pong is **generally not allowed** due to similarity to Lab 8 unless it is a significantly unique take (e.g. 3D pong).
- Hardware implementations of classic CPUs or computers (e.g. NES on FPGA, C64 on FPGA)
- **SLC-3 extensions require special approval to ensure they are not identical to work done in other classes (e.g. 411 implements full LC-3, pipelining, cache, so these are not allowed as projects)**
- Audio or music DSP algorithms (speaker correction, reverberation, equalization, sound synthesis)
- Accelerated 2D or 3D graphics (e.g. 3D accelerator for Nios II based SoC)
- Artificial neural network applications (object identification, handwriting recognition, voice recognition)

### Additional notes:



基于你提供的已完成的基础功能（VGA显示、键盘输入控制和文字显示），我们可以更具体地评估这三个FPGA项目（实现神经网络控制飞机大战游戏、复现《植物大战僵尸》和实现俄罗斯方块）的难度和时间需求。这些功能为涉及图形显示和用户交互的项目提供了重要的基础，因此可以减少一些开发工作量。

### 难度和时间需求分析：

1. **实现俄罗斯方块**：
   - **难度**：中等。逻辑相对简单且清晰，主要涉及方块的生成、移动、旋转和消除逻辑。
   - **预计时间**：由于基本的显示和输入控制已经完成，主要的开发集中在游戏逻辑和细节调试上。预计完成时间为1-2个月。

2. **复现《植物大战僵尸》**：
   - **难度**：较高。这个游戏涉及更复杂的游戏逻辑，如多种植物和僵尸的行为，以及较复杂的游戏状态管理。
   - **预计时间**：需要设计多个游戏角色和事件逻辑，以及复杂的游戏进度控制。预计完成时间为3-4个月。

3. **使用FPGA实现神经网络控制的飞机大战游戏**：
   - **难度**：最高。涉及到神经网络的设计和实现，这在FPGA上通常比较复杂，尤其是涉及到高效实现和资源优化。
   - **预计时间**：神经网络的设计、训练以及在FPGA上的实现和优化需要较长的时间，特别是如果需要处理实时反馈和动态环境调整。预计完成时间为4-6个月，具体取决于网络的复杂度和所需性能。

### 总结难度排序：
1. 使用FPGA实现神经网络控制的飞机大战游戏（最难）
2. 复现《植物大战僵尸》
3. 实现俄罗斯方块（相对容易）

这些估计基于一般的项目进度和难度，实际情况可能根据具体的技术栈、团队经验以及具体实现的功能需求有所变化。每个项目都应该考虑适当的时间安排用于测试和优化阶段，以确保最终实现的质量和性能。



在FPGA开发中使用SystemVerilog确实可以实现一些面向对象编程（OOP）的特性，但这与在传统软件编程中使用OOP有所不同。SystemVerilog扩展了Verilog的功能，引入了面向对象的概念，主要用于测试和验证环境，而在硬件设计和实现上的应用则有限。

### SystemVerilog的面向对象特性

SystemVerilog的OOP主要包括以下几个方面：

1. **类（Classes）**：
   - SystemVerilog 允许定义类，这些类可以包含属性（数据成员）和方法（成员函数）。
   - 类可以继承自其他类，支持多态和封装。

2. **构造函数**：
   - 类可以有构造函数来初始化对象。

3. **封装**：
   - 可以将数据和操作数据的方法封装在一个类中，提供接口和实现的分离。

### 在FPGA中应用OOP

尽管SystemVerilog支持OOP特性，但在FPGA或其他硬件设计中直接应用OOP存在一些限制：

1. **综合和硬件实现**：
   - FPGA的硬件描述主要关注于可综合（synthesizable）代码，即能够被转换成实际硬件逻辑的代码。SystemVerilog中的许多OOP特性，如类和继承，通常不是可综合的。
   - 在硬件设计中，面向对象的模式更多是用于模块化设计和接口管理，而不是实现完整的OOP概念。

2. **主要用于验证**：
   - 在FPGA和ASIC的开发流程中，SystemVerilog的OOP特性主要被用于验证和测试环境。例如，使用类来创建测试环境，模拟复杂的系统交互，以及进行更高级的验证策略。

### 实际应用

在实际FPGA项目中，如果需要使用OOP概念，一般是将OOP作为模块化和代码复用的工具，而不是直接在硬件逻辑中实现面向对象的设计。例如，你可以在测试阶段使用SystemVerilog的OOP特性来设计测试框架，而在硬件设计阶段则依赖于更传统的结构化或模块化方法。

总结来说，虽然SystemVerilog提供了一些OOP的特性，但在FPGA开发中，这些特性主要适用于验证和测试，而不是硬件设计本身。面向对象的概念可以帮助提高代码的可读性和可维护性，但其在硬件实现中的应用是有限的。