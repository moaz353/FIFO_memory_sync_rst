quit -sim 

vlib work 

vlog qs_4_design.v qs_4_tb.v

vsim -voptargs=+acc FIFO_tb 

add wave * 

add wave -position insertpoint  \
sim:/FIFO_tb/DUT/w_ptr \
sim:/FIFO_tb/DUT/r_ptr \
sim:/FIFO_tb/DUT/FIFO_mem

run -all