library verilog;
use verilog.vl_types.all;
entity uart_top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \as_\           : in     vl_logic;
        \cs_\           : in     vl_logic;
        rw              : in     vl_logic;
        addr            : in     vl_logic;
        wr_data         : in     vl_logic_vector(31 downto 0);
        rd_data         : out    vl_logic_vector(31 downto 0);
        \rdy_\          : out    vl_logic;
        irq_tx          : out    vl_logic;
        irq_rx          : out    vl_logic;
        rx              : in     vl_logic;
        tx              : out    vl_logic
    );
end uart_top;
