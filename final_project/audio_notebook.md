# Audio On FPGA Notebook

2024年5月23日

要在FPGA上播放音效，需要确保音频数据能够通过音频驱动模块传送到WM8731音频编解码器，并最终输出到扬声器或耳机。以下是详细步骤，确保你的音效能正常播放：

## 1. 初始化音频编解码器



首先，你需要正确初始化音频编解码器。通过设置`INIT`信号为高，然后等待`INIT_FINISH`信号变为高，表示初始化完成。

```vhdl
process(CLOCK_50, RESET)
begin
    if RESET = '1' then
        INIT <= '0';
    elsif rising_edge(CLOCK_50) then
        if INIT_FINISH = '0' then
            INIT <= '1';
        else
            INIT <= '0';
        end if;
    end if;
end process;
```

## 2. 播放音效数据

初始化完成后，需要持续向音频驱动提供音频数据。音频数据可以是预录制的声音样本或由FPGA生成的信号。

### 音频数据生成

下面的代码示例展示了如何根据游戏事件生成音频数据（例如：当游戏中的一行被清除时播放音效）。此例子生成一个简单的正弦波作为音效。

```vhdl
signal sine_wave: std_logic_vector(15 downto 0);
signal phase_accumulator: unsigned(31 downto 0) := (others => '0');
constant sine_wave_table: array (0 to 255) of std_logic_vector(15 downto 0) := (
    -- 256-point sine wave lookup table values
    "0000000000000000", "0000110011001100", -- ...
);

process(CLOCK_50, RESET)
begin
    if RESET = '1' then
        LDATA <= (others => '0');
        RDATA <= (others => '0');
        phase_accumulator <= (others => '0');
    elsif rising_edge(CLOCK_50) then
        if INIT_FINISH = '1' then
            if line_cleared_event = '1' then
                -- Increment the phase accumulator to generate the sine wave
                phase_accumulator <= phase_accumulator + 1;
                sine_wave <= sine_wave_table(to_integer(phase_accumulator(31 downto 24)));
                LDATA <= sine_wave;
                RDATA <= sine_wave;
            else
                LDATA <= (others => '0');
                RDATA <= (others => '0');
            end if;
        end if;
    end if;
end process;
```

### 预录制音频样本

如果你有预录制的音频样本，可以将它们存储在ROM中，然后在需要播放时读取样本数据并发送到音频驱动。以下是一个简单的ROM例子：

```vhdl
type rom_array is array (0 to 1023) of std_logic_vector(15 downto 0);
signal audio_rom: rom_array := (
    -- Pre-recorded audio samples
    "0000000000000000", "0000110011001100", -- ...
);

signal rom_addr: integer range 0 to 1023 := 0;

process(CLOCK_50, RESET)
begin
    if RESET = '1' then
        rom_addr <= 0;
        LDATA <= (others => '0');
        RDATA <= (others => '0');
    elsif rising_edge(CLOCK_50) then
        if INIT_FINISH = '1' then
            if play_audio_event = '1' then
                LDATA <= audio_rom(rom_addr);
                RDATA <= audio_rom(rom_addr);
                if rom_addr < 1023 then
                    rom_addr <= rom_addr + 1;
                else
                    rom_addr <= 0;
                end if;
            else
                LDATA <= (others => '0');
                RDATA <= (others => '0');
                rom_addr <= 0;
            end if;
        end if;
    end if;
end process;
```

### 注意事项

1. **音频采样率**：确保你的音频数据采样率与WM8731的配置一致。如果使用44100Hz采样率，则你的时钟和数据发送速率需要匹配。
2. **音频数据格式**：音频数据需要以16位二进制补码格式发送给`LDATA`和`RDATA`。
3. **时钟同步**：音频数据发送需要与音频时钟（例如 `AUD_BCLK`）同步。这在音频接口驱动中通常已经处理好，但你需要确保整体设计时钟与音频时钟协调。

通过以上步骤和注意事项，你应该能够在FPGA上成功播放音效，为你的Tetris游戏添加丰富的音频体验。如果有任何问题或需要进一步的帮助，请随时询问。

```
很好，我设置了lab8.sof 中的pin 口，在toplevel file里写了新的几个输入和声音的接口
{


	audio Audio_istance (.*, .Reset(Reset_h));
	 
	music music_instance(.*);
	 
	audio_interface music ( .LDATA (music_content),
									 .RDATA (music_content),
									 .Clk(Clk),
									 .Reset(Reset_h),
									 .INIT(INIT),
									 .INIT_FINISH(INIT_FINISH),
									 .adc_full (adc_full),
									 .data_over(data_over),
									 .AUD_MCLK(AUD_XCK),
									 .AUD_BCLK(AUD_BCLK),
									 .AUD_ADCDAT(AUD_ADCDAT),
									 .AUD_DACDAT(AUD_DACDAT),
									 .AUD_DACLRCK(AUD_DACLRCK),
									 .AUD_ADCLRCK(AUD_ADCLRCK),
									 .I2C_SDAT(I2C_SDAT),
									 .I2C_SCLK(I2C_SCLK),
									 .ADCDATA(ADCDATA),
									 
	 );


}
music.sv 内容如下：
{
module music (input logic  Clk,
				  input logic  [16:0]Add,
				  output logic [16:0]music_content);
				  
	logic [16:0] music_memory [0:83464];
	initial 
	begin 
		$readmemh("Tetris.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
			music_content <= music_memory[Add];
		end
endmodule
}
播放的音频文件是txt, 里面大概是 ：
{0001
0000
FFFE
FFFF
0001
FFFF
0000
FFFD
0002
FFFD
FFFF
FFFC
FFFE
0011
0030
FF9E
004A
FFE3
00B3
FFFD
...很长，大概3分钟的歌曲}

现在，我想知道我应该如何使用我的音频，在软件部分需要做什么
```



## 另外一个driver

https://kttechnology.wordpress.com/2018/11/10/ece-385-final-project-notes-simple-sound-effect/

https://www.eecg.toronto.edu/~jayar/ece241_08F/AudioVideoCores/audio/audio

## 音频控制器

### 目录

1. 介绍
2. 控制器接口
3. 端口描述
4. 接口描述
5. 控制器操作
6. 音频数据格式和模数转换
7. 数字到模拟转换
8. 模拟到数字转换
9. 音频控制器演示

### 1. 介绍

音频控制器为DE2板上的音频编解码器芯片提供了一个简单的接口。控制器处理与芯片的数据传输。芯片的配置由一个单独的配置模块处理。使用音频控制器时，必须单独实例化配置模块。

本文档将描述音频控制器的接口和操作，并概述编码声波所需的音频数据格式。

你可以在此下载音频控制器的源代码（Verilog）。

### 2. 控制器接口

#### 端口描述

图1展示了音频控制器接口（默认情况下，AUDIO_DATA_WIDTH等于32），输入在左侧，输出和双向线路在右侧。端口使用如下：

- `CLOCK_50` - 系统时钟输入，必须为50MHz才能正确工作。
- `reset` - 高电平有效复位信号。
- `AUD_ADCDAT`、`AUD_DACDAT`、`AUD_BCLK`、`AUD_ADCLRCK`、`AUD_DACLRCK`、`I2C_SDAT`、`I2C_SCLK`和`AUD_XCK` - 连接到芯片相应引脚的外部线路，具体定义见该文件。

用于接收数据的端口：
- `left_channel_audio_in`和`right_channel_audio_in` - 从外部源接收的音频数据。
- `read_audio_in` - 读使能信号。音频输入数据（如果有）将在下一个时钟周期放置在数据线上。这是一个电平敏感信号，意味着只要`read_audio_in`为高电平，每个边缘都会读取新数据样本。
- `audio_in_available` - 表示输入数据是否可用。除非此信号为高，否则读取不会有任何效果。

用于发送数据的端口：
- `left_channel_audio_out`和`right_channel_audio_out` - 播放的音频数据。
- `write_audio_out` - 写入新数据的使能信号。电平敏感信号，当此信号为高时，每个时钟边缘都会写入数据。
- `audio_out_allowed` - 指示何时可以写入数据。除非此信号为高，否则写入不会有任何效果。

### 3. 接口描述

音频控制器支持全双工音频输入和输出。数据端口默认宽度为32位，并连接到数据缓冲区。`clear_audio_in_memory`和`clear_audio_out_memory`信号可用于清除缓冲区，`audio_in_available`和`audio_out_allowed`信号分别指示数据（输入情况下）或缓冲区空闲空间（输出情况下）的可用性。数据本身是表示一个音频样本的有符号整数。所有信号都同步到同一个时钟。发送和接收数据的接口协议分别如图2和图3所示。

### 4. 控制器操作

音频控制器由两部分组成：输入模块和输出模块。本节将简要概述每个模块。

音频输入和输出模块由连接到数据缓冲区的移位寄存器组成。

在音频输出的情况下，从用户接收到的数据被缓冲，然后以适当的速率移出到音频芯片。音频芯片然后将这些数据直接传输到DAC。

在音频输入的情况下，过程相反：从音频芯片接收到的数据被移入并放置在数据缓冲区中。数据直接来自音频芯片上的ADC。

### 5. 音频数据格式和模数转换

音频控制器使用原始PCM数据流进行输入和输出。PCM数据流本质上是一系列数字，表示给定时刻的信号强度。这些数字中的每一个称为一个样本。声音可以通过一系列样本来表示（即采样）。这个序列有一个与之相关的频率，表示原始信号的采样速率。这个采样率对于正确的信号重建是必要的。

对于音频控制器，默认采样率为48kHz，默认样本大小为32位。此外，输入和输出均有2个通道。如果需要，可以在配置时更改采样率和样本大小。音频样本以二进制补码形式表示。

### 6. 数字到模拟转换

对于音频播放，PCM数据直接输入到DAC，后者将值转换为电压。这个模拟电压输出连接到DE2板上的Line-out插孔，可以驱动耳机或扬声器。此过程如图4所示。

### 7. 模拟到数字转换

对于音频输入（或录音），过程相反。你可以将麦克风连接到DE2板上的Mic插孔，或将其他设备连接到Line-in插孔（但不能同时连接这两者）。这些插孔连接到ADC的输入端，后者将电压转换为数字值。然后此值传输到音频控制器。此过程如图5所示。

### 8. 音频控制器演示

使用音频控制器的示例电路可以在此下载。提供了完整的Quartus项目和已编译好的.sof文件，准备好可编程。

该电路的主要功能非常简单。其主要功能是生成一些不同频率的信号，并使用音频控制器播放这些信号。信号频率由DE2板上的0到3号开关选择。连接Line-out输出到扬声器后，根据开关设置的不同，你应该能听到不同频率的声音。当四个开关全部关闭时，不会生成任何声音。

电路的次要功能是将麦克风输入叠加在生成的信号上。如果将麦克风连接到Mic插孔，你应该能够听到麦克风的声音叠加在电路生成的信号上。