iverilog 
-D ROM_PRG = "test.dat" 
//-D SPM_PRG = \"SPM镜像文件\" 
-D SIM_CYCLE = 1000      
-o chip_top.out 
-s chip_top_test       

-I CPU\include
-I BUS\include
-I IO\include
-I CLK\include

-y C:\Users\ririkaka\Desktop\cpu试验品\lib


//工作目录
chip_top_test.v
bus_top.v
chip.v
chip_top.v
clk_gen.v
cpu_top.v
gpio.v
rom.v
timer.v 
uart_top.v

