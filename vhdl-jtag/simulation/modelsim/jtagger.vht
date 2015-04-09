-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "04/06/2015 13:38:34"
                                                            
-- Vhdl Test Bench template for design  :  jtagger
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY jtagger_vhd_tst IS
END jtagger_vhd_tst;
ARCHITECTURE jtagger_arch OF jtagger_vhd_tst IS
-- constants                                                 
constant clk_per: time := 10 ns;

-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL cpld_sel_asynch : STD_LOGIC;
SIGNAL gpio : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL gpo : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL pc_tck : STD_LOGIC;
SIGNAL pc_tdi : STD_LOGIC;
SIGNAL pc_tdo : STD_LOGIC;
SIGNAL pc_tms : STD_LOGIC;
SIGNAL targ_tck : STD_LOGIC;
SIGNAL targ_tdi : STD_LOGIC;
SIGNAL targ_tdo : STD_LOGIC;
SIGNAL targ_tms : STD_LOGIC;
SIGNAL tck_clk : STD_LOGIC;
COMPONENT jtagger
	PORT (
	clk : IN STD_LOGIC;
	cpld_sel_asynch : IN STD_LOGIC;
	gpio : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	gpo : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	pc_tck : IN STD_LOGIC;
	pc_tdi : IN STD_LOGIC;
	pc_tdo : OUT STD_LOGIC;
	pc_tms : IN STD_LOGIC;
	targ_tck : INOUT STD_LOGIC;
	targ_tdi : INOUT STD_LOGIC;
	targ_tdo : INOUT STD_LOGIC;
	targ_tms : INOUT STD_LOGIC;
	tck_clk : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : jtagger
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	cpld_sel_asynch => cpld_sel_asynch,
	gpio => gpio,
	gpo => gpo,
	pc_tck => pc_tck,
	pc_tdi => pc_tdi,
	pc_tdo => pc_tdo,
	pc_tms => pc_tms,
	targ_tck => targ_tck,
	targ_tdi => targ_tdi,
	targ_tdo => targ_tdo,
	targ_tms => targ_tms,
	tck_clk => tck_clk
	);
init : PROCESS                                               
-- variable declarations                                     



BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           


pClk: process
begin
	clk <= '1';
	wait for clk_per/2;
	clk <= '0';
	wait for clk_per/2;
end process;

END jtagger_arch;
