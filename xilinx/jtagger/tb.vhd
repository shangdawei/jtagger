--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:44:55 04/06/2015
-- Design Name:   
-- Module Name:   /home/cmp/git/jtagger/xilinx/jtagger/tb.vhd
-- Project Name:  jtagger
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: jtagger
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_ulogic and
-- std_ulogic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT jtagger
    PORT(
         pc_tck : IN  std_ulogic;
         pc_tdi : IN  std_ulogic;
         pc_tms : IN  std_ulogic;
         pc_tdo : OUT  std_ulogic;
         cpld_sel_asynch : IN  std_ulogic;
         targ_tck : INOUT  std_ulogic;
         targ_tdi : INOUT  std_ulogic;
         targ_tms : INOUT  std_ulogic;
         targ_tdo : INOUT  std_ulogic;
         gpio : INOUT  std_logic_vector(3 downto 0);
         gpo : OUT  std_ulogic_vector(2 downto 0);
         tck_clk : IN  std_ulogic;
         clk : IN  std_ulogic
        );
    END COMPONENT;
    

   --Inputs
   signal pc_tck : std_ulogic := '0';
   signal pc_tdi : std_ulogic := '0';
   signal pc_tms : std_ulogic := '0';
   signal cpld_sel_asynch : std_ulogic := '0';
   signal tck_clk : std_ulogic := '0';
   signal clk : std_ulogic := '0';

	--BiDirs
   signal targ_tck : std_ulogic;
   signal targ_tdi : std_ulogic;
   signal targ_tms : std_ulogic;
   signal targ_tdo : std_ulogic;
   signal gpio : std_logic_vector(3 downto 0);

 	--Outputs
   signal pc_tdo : std_ulogic;
   signal gpo : std_ulogic_vector(2 downto 0);

   -- Clock period definitions
   constant tck_clk_period : time := 100 ns;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: jtagger PORT MAP (
          pc_tck => pc_tck,
          pc_tdi => pc_tdi,
          pc_tms => pc_tms,
          pc_tdo => pc_tdo,
          cpld_sel_asynch => cpld_sel_asynch,
          targ_tck => targ_tck,
          targ_tdi => targ_tdi,
          targ_tms => targ_tms,
          targ_tdo => targ_tdo,
          gpio => gpio,
          gpo => gpo,
          tck_clk => tck_clk,
          clk => clk
        );

 
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

    stim_process: process
    
        procedure write_byte(data: in std_ulogic_vector(7 downto 0)) is
        begin
        for I in 7 downto 0 loop
            tck_clk <= '0';
            pc_tdi <= data(I);
            wait for tck_clk_period/2;
            tck_clk <= '1';
            wait for tck_clk_period/2;
        end loop;
        end procedure;
     begin
        --- set GPIO = 0xA
        gpio <= "ZZZZ";
        cpld_sel_asynch <= '1';
        wait for 50 ns;
        cpld_sel_asynch <= '0';
        wait for tck_clk_period;
        write_byte(x"00");
        write_byte(x"a0");
        cpld_sel_asynch <= '1';
        wait for 500 ns;
        
        --- tristate GPIO, force GPIO = 0xC, read out
        cpld_sel_asynch <= '0';
        wait for tck_clk_period;
        write_byte(x"0f");
        write_byte(x"00");
        cpld_sel_asynch <= '1';
        wait for tck_clk_period;
        
        gpio <= x"C";
        wait for tck_clk_period;
        cpld_sel_asynch <= '0';
        wait for tck_clk_period;
        write_byte(x"0f");
        write_byte(x"00");
        cpld_sel_asynch <= '1';
        wait;
    end process;

END;
