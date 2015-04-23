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

.PHONY: all clean

all: ${TOPLEVEL}.bit

%.ngc: %.xst %.prj ${VHDL}
	@echo ----
	$(call echo_cyan,"Performing synthesis...")
	mkdir -p xst/projnav.tmp
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

clean:
	rm -fr _nog
	rm -fr xlnx_auto_0_xdb
	rm -fr _xmsgs
	rm -fr xst
	rm -f ${TOPLEVEL}.bgn
	rm -f ${TOPLEVEL}_bitgen.xwbt
	rm -f ${TOPLEVEL}.bld
	rm -f ${TOPLEVEL}.drc
	rm -f ${TOPLEVEL}.lso
	rm -f ${TOPLEVEL}_map.map
	rm -f ${TOPLEVEL}_map.mrp
	rm -f ${TOPLEVEL}_map.ncd
	rm -f ${TOPLEVEL}_map.ngm
	rm -f ${TOPLEVEL}_map.xrpt
	rm -f ${TOPLEVEL}_ngdbuild.xrpt
	rm -f ${TOPLEVEL}.ngr
	rm -f ${TOPLEVEL}.pad
	rm -f ${TOPLEVEL}_pad.csv
	rm -f ${TOPLEVEL}_pad.txt
	rm -f ${TOPLEVEL}.par
	rm -f ${TOPLEVEL}_par.xrpt
	rm -f ${TOPLEVEL}.ptwx
	rm -f ${TOPLEVEL}_summary.xml
	rm -f ${TOPLEVEL}.syr
	rm -f ${TOPLEVEL}.unroutes
	rm -f ${TOPLEVEL}_usage.xml
	rm -f ${TOPLEVEL}.xpi
	rm -f ${TOPLEVEL}_xst.xrpt
	rm -f usage_statistics_webtalk.html
	rm -f webtalk.log

