library verilog;
use verilog.vl_types.all;
entity chip is
    port(
        clk             : in     vl_logic;
        clkcounter      : in     vl_logic;
        reset           : in     vl_logic;
        rx              : in     vl_logic;
        tx              : out    vl_logic;
        gpio_in         : in     vl_logic_vector(3 downto 0);
        gpio_out        : out    vl_logic_vector(17 downto 0);
        gpio_io         : inout  vl_logic_vector(15 downto 0)
    );
end chip;
