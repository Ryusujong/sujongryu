`timescale 1ns / 1ps


module test_fifo ();

logic wr_clk;
logic full;
logic [7:0] din;
logic wr_en;

logic rd_clk;
logic empty;
logic [7:0] dout;
logic rd_en;

logic rst;
logic fifo_ready;

fifo_generator_0 fifo (
    .din(din),
    .full(full),
    .wr_en(wr_en),
    .empty(empty),
    .dout(dout),
    .rd_en(rd_en),
    .rst(rst),
    .wr_clk(wr_clk),
    .rd_clk(rd_clk)
  
  
   );
   


initial begin
    rst = 0;
    wr_clk = 0;
    rd_clk = 0;
    rd_en = 0;
    wr_en = 0;
    din = 0;
    dout = 0;
    fifo_ready = 0;
    
    #50 rst = 1;
    #50 rst = 0;
    
    #50 fifo_ready = 1;
end

always begin 
    #10
    wr_clk = ~wr_clk;
end


always begin
    #10
    rd_clk = ~rd_clk;
end

always_ff @(posedge wr_clk or negedge rst) begin
    if(rst) begin
       wr_en <= 0;
    end else begin
        if (fifo_ready) begin
        din <= din + 1;
        wr_en <= 1;       
    end
end 

always_ff @(posedge wr_clk or negedge rst) begin
    if(rst) begin
       rd_en <= 0;
    end else begin
        din <= din + 1;
        wr_en <= 1;       
    end
end 


   
endmodule
