onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_i2c_master/rst
add wave -noupdate /tb_i2c_master/clk
add wave -noupdate /tb_i2c_master/addr
add wave -noupdate /tb_i2c_master/dat
add wave -noupdate /tb_i2c_master/rw
add wave -noupdate /tb_i2c_master/sda
add wave -noupdate /tb_i2c_master/scl
add wave -noupdate /tb_i2c_master/sim_done
add wave -noupdate /tb_i2c_master/counter
add wave -noupdate /tb_i2c_master/i2c_master_b/clk_pi
add wave -noupdate /tb_i2c_master/i2c_master_b/rst_pi
add wave -noupdate /tb_i2c_master/i2c_master_b/addr_pi
add wave -noupdate /tb_i2c_master/i2c_master_b/dat_pi
add wave -noupdate /tb_i2c_master/i2c_master_b/rw_pi
add wave -noupdate /tb_i2c_master/i2c_master_b/sda_po
add wave -noupdate /tb_i2c_master/i2c_master_b/scl_po
add wave -noupdate /tb_i2c_master/i2c_master_b/counter
add wave -noupdate /tb_i2c_master/i2c_master_b/sda_counter
add wave -noupdate /tb_i2c_master/i2c_master_b/scl_counter
add wave -noupdate /tb_i2c_master/i2c_master_b/sda_clk
add wave -noupdate /tb_i2c_master/i2c_master_b/scl_clk
add wave -noupdate /tb_i2c_master/i2c_master_b/full_clk_toggle
add wave -noupdate /tb_i2c_master/i2c_master_b/c_st
add wave -noupdate /tb_i2c_master/i2c_master_b/n_st
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {280 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 267
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2630 ns}
