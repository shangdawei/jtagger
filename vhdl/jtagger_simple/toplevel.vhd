library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
port(
    -- System control
    vctrl: out std_ulogic;
    vppen: out std_ulogic;
    bufoe: out std_ulogic;
    tgtsense: in std_ulogic;

    -- Signals to port
    iopin_19: inout std_ulogic;
    iopin_17: inout std_ulogic;
    iopin_15: inout std_ulogic;
    iopin_13: inout std_ulogic;
    iopin_11: inout std_ulogic;
    iopin_9: inout std_ulogic;
    iopin_7: inout std_ulogic;
    iopin_5: inout std_ulogic;
    iopin_3: inout std_ulogic;
    
    -- PC data
    ftdi_ad0: inout std_ulogic;
    ftdi_ad1: inout std_ulogic;
    ftdi_ad2: inout std_ulogic;
    ftdi_ad3: inout std_ulogic;
    ftdi_ad4: inout std_ulogic;
    ftdi_ad5: inout std_ulogic;
    ftdi_ad6: inout std_ulogic;
    ftdi_ad7: inout std_ulogic;
    ftdi_ac1: inout std_ulogic;
    ftdi_ac2: inout std_ulogic;
    
    clk: in std_ulogic
    );
end toplevel;

architecture Behavioral of toplevel is

alias iopin_dbgack: std_ulogic is iopin_19;
alias iopin_dbgreq: std_ulogic is iopin_17;
alias iopin_n_srst: std_ulogic is iopin_15;
alias iopin_tdo: std_ulogic is iopin_13;
alias iopin_rtck: std_ulogic is iopin_11;
alias iopin_tck: std_ulogic is iopin_9;
alias iopin_tms: std_ulogic is iopin_7;
alias iopin_tdi: std_ulogic is iopin_5;
alias iopin_n_trst: std_ulogic is iopin_3;

alias ftdi_tck: std_ulogic is ftdi_ad0;
alias ftdi_tdi: std_ulogic is ftdi_ad1;
alias ftdi_tdo: std_ulogic is ftdi_ad2;
alias ftdi_tms: std_ulogic is ftdi_ad3;

begin

vctrl <= '0';
vppen <= '0';
bufoe <= '1';

iopin_tdi <= ftdi_tdi;
iopin_tck <= ftdi_tck;
iopin_tms <= ftdi_tms;
ftdi_tdo <= iopin_tdo;
iopin_n_srst <= 'Z';
iopin_rtck <= 'Z';
iopin_n_trst <= 'Z';
iopin_dbgack <= 'Z';
iopin_dbgreq <= 'Z';
iopin_tdo <= 'Z';

ftdi_ad4 <= 'Z';
ftdi_ad5 <= 'Z';
ftdi_ad6 <= 'Z';
ftdi_ad7 <= 'Z';
ftdi_ac1 <= 'Z';
ftdi_ac2 <= 'Z';

end Behavioral;

