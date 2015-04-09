transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/cmp/git/jtagger/vhdl-jtag/jtagger.vhd}

vcom -93 -work work {/home/cmp/git/jtagger/vhdl-jtag/simulation/modelsim/jtagger.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L max -L rtl_work -L work -voptargs="+acc"  main_test

add wave *
view structure
view signals
run -all
