library verilog;
use verilog.vl_types.all;
entity if_top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        busy            : out    vl_logic;
        spm_rd_data     : in     vl_logic_vector(31 downto 0);
        \spm_as_\       : out    vl_logic;
        spm_addr        : out    vl_logic_vector(29 downto 0);
        spm_wr_data     : out    vl_logic_vector(31 downto 0);
        spm_rw          : out    vl_logic;
        bus_rd_data     : in     vl_logic_vector(31 downto 0);
        \bus_rdy_\      : in     vl_logic;
        \bus_grnt_\     : in     vl_logic;
        \bus_as_\       : out    vl_logic;
        \bus_req_\      : out    vl_logic;
        bus_addr        : out    vl_logic_vector(29 downto 0);
        bus_rw          : out    vl_logic;
        bus_wr_data     : out    vl_logic_vector(31 downto 0);
        new_pc          : in     vl_logic_vector(29 downto 0);
        br_taken        : in     vl_logic;
        br_addr         : in     vl_logic_vector(29 downto 0);
        if_en           : out    vl_logic;
        if_pc           : out    vl_logic_vector(29 downto 0);
        if_insn         : out    vl_logic_vector(31 downto 0)
    );
end if_top;
