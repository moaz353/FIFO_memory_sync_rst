module FIFO_tb ; 

reg [15:0] din_a ; 
reg wen_a , clk_a , ren_b , clk_b , rst ; 

wire [15:0] dout_b ; 
wire full , empty ;


FIFO DUT (.din_a(din_a) , .wen_a(wen_a) , .ren_b(ren_b) ,
            .clk_a(clk_a) , .clk_b(clk_b) , .rst(rst) , .dout_b(dout_b) , .full(full) , .empty(empty)) ; 

initial begin
    clk_a = 0 ; 
    clk_b = 0 ;
    forever begin
        #1 clk_a = ~ clk_a  ; 
        #1 clk_b = ~ clk_b  ;
    end
end

initial begin
    rst   = 1 ; 
    @(negedge clk_a) ;  
    rst   = 0 ;
    ren_b = 0 ;
    repeat(1000) begin
        din_a = $random  ; 
        wen_a = 1  ;
        @(negedge clk_a) ; 
    end
    wen_a = 0 ;
    repeat(1000) begin
        ren_b = 1  ;
        @(negedge clk_a) ; 
    end
    ren_b = 1 ; 
    wen_a = 1 ; 
    repeat(1000) begin
        din_a = $random  ; 
        wen_a = $random  ;
        ren_b = $random  ; 
        @(negedge clk_a) ; 
    end
    $stop ;
end
endmodule 