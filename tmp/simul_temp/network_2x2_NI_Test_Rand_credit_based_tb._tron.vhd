------------------------------------------------------------
-- This file is automatically generated Please do not change!
-- Here are the parameters:
-- 	 network size x:2
-- 	 network size y:2
-- 	 data width:32-- 	 traffic pattern:------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.TB_Package.all;

USE ieee.numeric_std.ALL;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

entity tb_network_2x2 is
end tb_network_2x2;


architecture behavior of tb_network_2x2 is

-- Declaring network component
component network_2x2 is
 generic (DATA_WIDTH: integer := 32; DATA_WIDTH_LV: integer := 11);
port (reset: in  std_logic;
	clk: in  std_logic;
	Rxy_reconf: in  std_logic_vector(7 downto 0);
	Reconfig : in std_logic;
	--------------
	RX_L_0: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_0, valid_out_L_0: out std_logic;
	credit_in_L_0, valid_in_L_0: in std_logic;
	TX_L_0: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_1: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_1, valid_out_L_1: out std_logic;
	credit_in_L_1, valid_in_L_1: in std_logic;
	TX_L_1: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_2: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_2, valid_out_L_2: out std_logic;
	credit_in_L_2, valid_in_L_2: in std_logic;
	TX_L_2: out std_logic_vector (DATA_WIDTH-1 downto 0);
	--------------
	RX_L_3: in std_logic_vector (DATA_WIDTH-1 downto 0);
	credit_out_L_3, valid_out_L_3: out std_logic;
	credit_in_L_3, valid_in_L_3: in std_logic;
	TX_L_3: out std_logic_vector (DATA_WIDTH-1 downto 0)

            );
end component;

-- generating bulk signals...
	signal RX_L_0, TX_L_0:  std_logic_vector (31 downto 0);
	signal credit_counter_out_0:  std_logic_vector (1 downto 0);
	signal credit_out_L_0, credit_in_L_0, valid_in_L_0, valid_out_L_0: std_logic;
	signal RX_L_1, TX_L_1:  std_logic_vector (31 downto 0);
	signal credit_counter_out_1:  std_logic_vector (1 downto 0);
	signal credit_out_L_1, credit_in_L_1, valid_in_L_1, valid_out_L_1: std_logic;
	signal RX_L_2, TX_L_2:  std_logic_vector (31 downto 0);
	signal credit_counter_out_2:  std_logic_vector (1 downto 0);
	signal credit_out_L_2, credit_in_L_2, valid_in_L_2, valid_out_L_2: std_logic;
	signal RX_L_3, TX_L_3:  std_logic_vector (31 downto 0);
	signal credit_counter_out_3:  std_logic_vector (1 downto 0);
	signal credit_out_L_3, credit_in_L_3, valid_in_L_3, valid_out_L_3: std_logic;
	-- NI testing signals
	--------------

signal Rxy_reconf: std_logic_vector (7 downto 0) := "01111101";
signal Reconfig: std_logic := '0';
 constant clk_period : time := 1 ns;
signal reset, not_reset, clk: std_logic :='0';

begin

   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

reset <= '1' after 1 ns;
-- instantiating the network
NoC: network_2x2 generic map (DATA_WIDTH  => 32, DATA_WIDTH_LV => 11)
port map (reset, clk, Rxy_reconf, Reconfig,
	RX_L_0, credit_out_L_0, valid_out_L_0, credit_in_L_0, valid_in_L_0,  TX_L_0,
	RX_L_1, credit_out_L_1, valid_out_L_1, credit_in_L_1, valid_in_L_1,  TX_L_1,
	RX_L_2, credit_out_L_2, valid_out_L_2, credit_in_L_2, valid_in_L_2,  TX_L_2,
	RX_L_3, credit_out_L_3, valid_out_L_3, credit_in_L_3, valid_in_L_3,  TX_L_3
            );
not_reset <= not reset;

-- connecting the packet generators
credit_counter_control(clk, credit_out_L_0, valid_in_L_0, credit_counter_out_0);
gen_random_packet(2, 10, 7, 3, 3, 10000 ns, clk, credit_counter_out_0, valid_in_L_0, RX_L_0); -- if i have no source then how it will check which port coming from

credit_counter_control(clk, credit_out_L_1, valid_in_L_1, credit_counter_out_1);
gen_random_packet(2, 10, 33, 3, 3, 10000 ns, clk, credit_counter_out_1, valid_in_L_1, RX_L_1);

credit_counter_control(clk, credit_out_L_2, valid_in_L_2, credit_counter_out_2);
gen_random_packet(2, 10, 3, 3, 3, 10000 ns, clk, credit_counter_out_2, valid_in_L_2, RX_L_2);

credit_counter_control(clk, credit_out_L_3, valid_in_L_3, credit_counter_out_3);
gen_random_packet(2, 10, 9, 3, 3, 10000 ns, clk, credit_counter_out_3, valid_in_L_3, RX_L_3);


-- connecting the packet receivers
get_packet(32, 5, 0, clk, credit_in_L_0, valid_out_L_0, TX_L_0);
get_packet(32, 5, 1, clk, credit_in_L_1, valid_out_L_1, TX_L_1);
get_packet(32, 5, 2, clk, credit_in_L_2, valid_out_L_2, TX_L_2);
get_packet(32, 5, 3, clk, credit_in_L_3, valid_out_L_3, TX_L_3);


end;
