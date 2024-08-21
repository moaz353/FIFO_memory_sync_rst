module FIFO (din_a , wen_a , ren_b , clk_a , clk_b , rst ,
                    dout_b , full , empty );

parameter FIFO_WIDTH = 16  ;
parameter FIFO_DEPTH = 512 ; 
parameter ptr_size   = 9 ; 

input [FIFO_WIDTH-1:0] din_a ; 
input wen_a , clk_a , ren_b , clk_b , rst ; 

output reg [FIFO_WIDTH-1:0] dout_b ; 
output  full , empty ; 

reg [ptr_size:0] w_ptr ; 
reg [ptr_size:0] r_ptr ; 

reg [FIFO_WIDTH-1:0] FIFO_mem [FIFO_DEPTH-1:0] ; 

// op_a > write 
always @(posedge clk_a) begin
    if (rst)
            w_ptr <= 0 ; 
    else begin 
        if (wen_a && full != 1 ) begin 
            FIFO_mem[w_ptr[ptr_size-1:0]] <= din_a     ; 
            w_ptr           <= w_ptr + 1 ; 
        end 
    end
end

// op_b > read 
always @(posedge clk_b) begin
    if(rst)
        r_ptr <= 0 ; 
    else begin 
        if (ren_b && empty != 1 ) begin 
            dout_b <= FIFO_mem[r_ptr[ptr_size-1:0]]   ; 
            r_ptr  <= r_ptr  +  1       ; 
        end
    end
end

assign empty = (w_ptr == r_ptr)? 1 : 0 ; 
assign full  = ( (w_ptr[ptr_size] != r_ptr[ptr_size]) && (w_ptr[ptr_size-1:0] == r_ptr[ptr_size-1:0]))? 1 : 0 ;


endmodule









