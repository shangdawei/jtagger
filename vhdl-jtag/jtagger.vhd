library ieee;
use ieee.std_logic_1164.all;

entity jtagger is
port (
    pc_tck: in std_ulogic;
    pc_tdi: in std_ulogic;
    pc_tms: in std_ulogic;
    pc_tdo: out std_ulogic;

    cpld_sel_asynch: in std_ulogic;

    targ_tck: inout std_ulogic;
    targ_tdi: inout std_ulogic;
    targ_tms: inout std_ulogic;
    targ_tdo: inout std_ulogic;

    gpio: inout std_logic_vector(3 downto 0);
    gpo: out std_ulogic_vector(2 downto 0);
    gpi: in std_ulogic_vector(1 downto 0);

    tck_clk: in std_ulogic;
    clk: in std_ulogic );
end jtagger;

architecture rtl of jtagger is

    constant shiftreg_len: integer := 32;
    signal shiftreg: std_ulogic_vector(shiftreg_len-1 downto 0) := (others => '0');
    signal shiftreg_latched: std_ulogic_vector(shiftreg_len-1 downto 0) := (others => '0');
    signal gpio_shift: std_ulogic_vector(5 downto 0) := (others => '0');

    signal cpld_sel_synch1: std_ulogic;
    signal cpld_sel: std_ulogic;
    signal cpld_sel_delayed: std_ulogic;
    signal cpld_sel_fedge: std_ulogic;
    signal cpld_sel_redge: std_ulogic;
    signal tck_delayed: std_ulogic;
    signal tck_redge: std_ulogic;

    alias cfg_ntristate: std_ulogic is shiftreg_latched(0);
    alias gpio_out: std_ulogic_vector(3 downto 0) is shiftreg_latched(7 downto 4);
    alias gpio_ntri: std_ulogic_vector(3 downto 0) is shiftreg_latched(11 downto 8);

    -- X X X X #tri3 #tri2 #tri1 #tri0          out3 out2 out1 out0 gpo2 gpo1 gpo0 #triall
begin

    gpo(0) <= shiftreg_latched(1);
    gpo(1) <= shiftreg_latched(2);
    gpo(2) <= shiftreg_latched(3);

    cpld_sel_synch1 <= cpld_sel_asynch when rising_edge(clk);
    cpld_sel <= cpld_sel_synch1 when rising_edge(clk);
    cpld_sel_delayed <= cpld_sel when rising_edge(clk);
    cpld_sel_redge <= not cpld_sel_delayed and cpld_sel;
    cpld_sel_fedge <= cpld_sel_delayed and not cpld_sel;

    tck_delayed <= tck_clk when rising_edge(clk);
    tck_redge <= not tck_delayed and tck_clk;

    process (clk, cpld_sel_fedge)
    begin
        if (rising_edge (clk)) then
            if (cpld_sel_redge = '1') then
                shiftreg_latched <= shiftreg;
            elsif (cpld_sel_fedge = '1') then
                gpio_shift <= std_ulogic_vector(gpio) & std_ulogic_vector(gpi);
            elsif (tck_redge = '1') then
                shiftreg(shiftreg_len-1 downto 1) <= shiftreg(shiftreg_len-2 downto 0);
                shiftreg(0) <= pc_tdi;
                gpio_shift(gpio_shift'high downto 1) <= gpio_shift(gpio_shift'high-1 downto 0);
                gpio_shift(0) <= '0';
            end if;
        end if;
    end process;

    process (cpld_sel, pc_tck, tck_clk, pc_tdi, pc_tms, targ_tdo, gpio_shift)
    begin
        if (cpld_sel = '0' or cfg_ntristate = '1') then
            targ_tck <= 'Z';
            targ_tdi <= 'Z';
            targ_tms <= 'Z';
            targ_tdo <= 'Z';
            pc_tdo <= gpio_shift(gpio_shift'high);
        else
            targ_tck <= tck_clk;
            targ_tdi <= pc_tdi;
            targ_tms <= pc_tms;
            targ_tdo <= 'Z';
            pc_tdo <= targ_tdo;
        end if;
    end process;

    -- GPIO
    process (clk, gpio, gpio_out, gpio_ntri)
    begin
        for I in 0 to 3 loop
            if (rising_edge (clk)) then
                if (gpio_ntri(I) = '0') then
                    gpio(I) <= 'Z';
                else
                    gpio(I) <= gpio_out(I);
                end if;
            end if;
        end loop;
    end process;

end rtl;
