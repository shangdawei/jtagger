# jtagger?

Well, it's not really just a jtagger, but I've been calling it that. It's also
been christened the Bit Quacker... uh, because it quacks? \*shrug\*

The basis for this design is sort of like the [Bus Blaster](http://dangerousprototypes.com/docs/Bus_Blaster), with a few nice mods. It's smaller (I'm working on V2, which may or may not ever be finished, which will be even smaller), it has an FPGA instead of a CPLD (not only more versatile, but will never be worn out by writes and rewrites), it's 5V-capable, and it can even do up to 13V on one pin, to enable programming microcontrollers with HVP.

The idea is that this can be adapted to program (as close to literally as possible) _any_ serial-programmed logic device, and debugging can be done as well.

In its most basic form, it's compatible with FT2232-compatible JTAG tools, as a simple firmware can be loaded to the FPGA that just passes the [MPSSE](http://www.ftdichip.com/Support/Documents/AppNotes/AN_135_MPSSE_Basics.pdf) signals straight through. The second port on the FT2232 can program the FPGA, so it's self-programming (it does, however, have a flash memory, so it can be preloaded with a firmware to skip this step).
