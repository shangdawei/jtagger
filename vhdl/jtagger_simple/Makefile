VHDL = $(wildcard *.vhd)
TOPLEVEL = toplevel
CHIP = xc3s50-5-vq100

XILINX_PREF_64 ?= /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64
XILINX_PREF ?= ${XILINX_PREF_64}

XST ?= ${XILINX_PREF}/xst
NGDBUILD ?= ${XILINX_PREF}/ngdbuild
MAP ?= ${XILINX_PREF}/map
PAR ?= ${XILINX_PREF}/par
TRCE ?= ${XILINX_PREF}/trce
BITGEN ?= ${XILINX_PREF}/bitgen

define echo_cyan
	@tput setaf 6
	@echo $1
	@tput sgr0
endef

define echo_greenbold
	@tput setaf 2
	@tput bold
	@echo $1
	@tput sgr0
endef

.PHONY: all

all: ${TOPLEVEL}.bit

%.ngc: %.xst %.prj ${VHDL}
	@echo ----
	$(call echo_cyan,"Performing synthesis...")
	${XST} -ifn $< -ofn $(patsubst %.xst,%.syr,$<) | bash ../ise_filter
	$(call echo_greenbold,"Full report in $(patsubst %.xst,%.syr,$<)")

%.ngd: %.ngc %.ucf
	@echo ----
	$(call echo_cyan,"Generating Native Generic Database...")
	${NGDBUILD} -dd _nog -nt timestamp -p ${CHIP} -uc $(patsubst %.ngc,%.ucf,$<) $< $@ | bash ../ise_filter
	$(call echo_greenbold,"Full report in $(patsubst %.ngc,%.bld,$<)")

%.pcf: %.ngd
	@echo ----
	$(call echo_cyan,"Map...")
	${MAP} -p ${CHIP} -cm area -ir off -pr off -c 100 -o $(patsubst %.ngd,%_map.ncd,$<) $< $@ | bash ../ise_filter
	$(call echo_greenbold,"Full report in $(patsubst %.ngd,%_map.mrp,$<)")

%.ncd: %.pcf
	@echo ----
	$(call echo_cyan,"PAR...")
	${PAR} -w -ol std -t 1 $(patsubst %.pcf,%_map.ncd,$<) $@ $< | bash ../ise_filter
	$(call echo_greenbold,"Full report in $(patsubst %.pcf,%.par,$<)")

%.twr: %.ucf %.ncd
	@echo ----
	$(call echo_cyan,"Timing analysis...")
	${TRCE} -v 3 -s 4 $(patsubst %.ucf,%.ncd,$<) -o $@ $(patsubst %.ucf,%.pcf,$<) -ucf $< | bash ../ise_filter

%.bit: %.ut %.ncd
	@echo ----
	$(call echo_cyan,"Writing bitfile...")
	${BITGEN} -f $^ | bash ../ise_filter
