// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps
module top_wrapper_gmem3_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 16,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    input  wire [11:0]                   memory_in_address0,
    input  wire                          memory_in_ce0,
    output wire [44:0]                   memory_in_q0
);
//------------------------Address Info-------------------
// Protocol Used: ap_ctrl_none
//
// 0x8000 ~
// 0xffff : Memory 'memory_in' (2250 * 45b)
//          Word 2n   : bit [31:0] - memory_in[n][31: 0]
//          Word 2n+1 : bit [12:0] - memory_in[n][44:32]
//                      others     - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_MEMORY_IN_BASE = 16'h8000,
    ADDR_MEMORY_IN_HIGH = 16'hffff,
    WRIDLE              = 2'd0,
    WRDATA              = 2'd1,
    WRRESP              = 2'd2,
    WRRESET             = 2'd3,
    RDIDLE              = 2'd0,
    RDDATA              = 2'd1,
    RDRESET             = 2'd2,
    ADDR_BITS                = 16;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // memory signals
    wire [11:0]                   int_memory_in_address0;
    wire                          int_memory_in_ce0;
    wire [47:0]                   int_memory_in_q0;
    wire [11:0]                   int_memory_in_address1;
    wire                          int_memory_in_ce1;
    wire                          int_memory_in_we1;
    wire [5:0]                    int_memory_in_be1;
    wire [47:0]                   int_memory_in_d1;
    wire [47:0]                   int_memory_in_q1;
    reg                           int_memory_in_read;
    reg                           int_memory_in_write;
    reg  [0:0]                    int_memory_in_shift1;

//------------------------Instantiation------------------
// int_memory_in
top_wrapper_gmem3_s_axi_ram #(
    .MEM_STYLE ( "auto" ),
    .MEM_TYPE  ( "2P" ),
    .BYTES     ( 6 ),
    .DEPTH     ( 2250 )
) int_memory_in (
    .clk0      ( ACLK ),
    .address0  ( int_memory_in_address0 ),
    .ce0       ( int_memory_in_ce0 ),
    .we0       ( {6{1'b0}} ),
    .d0        ( {45{1'b0}} ),
    .q0        ( int_memory_in_q0 ),
    .clk1      ( ACLK ),
    .address1  ( int_memory_in_address1 ),
    .ce1       ( int_memory_in_ce1 ),
    .we1       ( int_memory_in_be1 ),
    .d1        ( int_memory_in_d1 ),
    .q1        ( int_memory_in_q1 )
);


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA) && (!ar_hs);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (w_hs)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= {AWADDR[ADDR_BITS-1:2], {2{1'b0}}};
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA) & !int_memory_in_read;
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
        end
        else if (int_memory_in_read) begin
            rdata <= int_memory_in_q1 >> (int_memory_in_shift1 * 32);
        end
    end
end


//------------------------Register logic-----------------

//------------------------Memory logic-------------------
// memory_in
assign int_memory_in_address0 = memory_in_address0;
assign int_memory_in_ce0      = memory_in_ce0;
assign memory_in_q0           = int_memory_in_q0;
assign int_memory_in_address1 = ar_hs? raddr[14:3] : waddr[14:3];
assign int_memory_in_ce1      = ar_hs | (int_memory_in_write & WVALID);
assign int_memory_in_we1      = int_memory_in_write & w_hs;
assign int_memory_in_be1      = int_memory_in_we1 ? WSTRB << (waddr[2:2] * 4) : 'b0;
assign int_memory_in_d1       = {2{WDATA}};
// int_memory_in_read
always @(posedge ACLK) begin
    if (ARESET)
        int_memory_in_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_MEMORY_IN_BASE && raddr <= ADDR_MEMORY_IN_HIGH)
            int_memory_in_read <= 1'b1;
        else
            int_memory_in_read <= 1'b0;
    end
end

// int_memory_in_write
always @(posedge ACLK) begin
    if (ARESET)
        int_memory_in_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_MEMORY_IN_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_MEMORY_IN_HIGH)
            int_memory_in_write <= 1'b1;
        else if (w_hs)
            int_memory_in_write <= 1'b0;
    end
end

// int_memory_in_shift1
always @(posedge ACLK) begin
    if (ARESET)
        int_memory_in_shift1 <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs)
            int_memory_in_shift1 <= raddr[2:2];
    end
end


endmodule


`timescale 1ns/1ps

module top_wrapper_gmem3_s_axi_ram
#(parameter
    MEM_STYLE = "auto",
    MEM_TYPE  = "S2P",
    BYTES  = 4,
    DEPTH  = 256,
    AWIDTH = log2(DEPTH)
) (
    input  wire               clk0,
    input  wire [AWIDTH-1:0]  address0,
    input  wire               ce0,
    input  wire [BYTES-1:0]   we0,
    input  wire [BYTES*8-1:0] d0,
    output reg  [BYTES*8-1:0] q0,
    input  wire               clk1,
    input  wire [AWIDTH-1:0]  address1,
    input  wire               ce1,
    input  wire [BYTES-1:0]   we1,
    input  wire [BYTES*8-1:0] d1,
    output reg  [BYTES*8-1:0] q1
);
//------------------------ Parameters -------------------
localparam
    BYTE_WIDTH = 8,
    PORT0 = (MEM_TYPE == "S2P") ? "WO" : ((MEM_TYPE == "2P") ? "RO" : "RW"),
    PORT1 = (MEM_TYPE == "S2P") ? "RO" : "RW";
//------------------------Local signal-------------------
(* ram_style = MEM_STYLE*)
reg  [BYTES*8-1:0] mem[0:DEPTH-1];
wire re0, re1;
//------------------------Task and function--------------
function integer log2;
    input integer x;
    integer n, m;
begin
    n = 1;
    m = 2;
    while (m < x) begin
        n = n + 1;
        m = m * 2;
    end
    log2 = n;
end
endfunction
//------------------------Body---------------------------
generate
    if (MEM_STYLE == "hls_ultra" && PORT0 == "RW") begin
        assign re0 = ce0 & ~|we0;
    end else begin
        assign re0 = ce0;
    end
endgenerate

generate
    if (MEM_STYLE == "hls_ultra" && PORT1 == "RW") begin
        assign re1 = ce1 & ~|we1;
    end else begin
        assign re1 = ce1;
    end
endgenerate

// read port 0
generate if (PORT0 != "WO") begin
    always @(posedge clk0) begin
        if (re0) q0 <= mem[address0];
    end
end
endgenerate

// read port 1
generate if (PORT1 != "WO") begin
    always @(posedge clk1) begin
        if (re1) q1 <= mem[address1];
    end
end
endgenerate

integer i;
// write port 0
generate if (PORT0 != "RO") begin
    always @(posedge clk0) begin
        if (ce0)
        for (i = 0; i < BYTES; i = i + 1)
            if (we0[i])
                mem[address0][i*BYTE_WIDTH +: BYTE_WIDTH] <= d0[i*BYTE_WIDTH +: BYTE_WIDTH];
    end
end
endgenerate

// write port 1
generate if (PORT1 != "RO") begin
    always @(posedge clk1) begin
        if (ce1)
        for (i = 0; i < BYTES; i = i + 1)
            if (we1[i])
                mem[address1][i*BYTE_WIDTH +: BYTE_WIDTH] <= d1[i*BYTE_WIDTH +: BYTE_WIDTH];
    end
end
endgenerate

endmodule

