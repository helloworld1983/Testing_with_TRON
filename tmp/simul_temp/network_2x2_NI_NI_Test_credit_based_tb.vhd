--Copyright (C) 2016 Siavoosh Payandeh Azad
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
use work.mlite_pack.all;

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
component NoC_Node is
generic( current_address : integer := 0; stim_file: string :="code.txt";
	log_file  : string := "output.txt");

port( reset        : in std_logic;
      clk          : in std_logic;

        credit_in : in std_logic;
        valid_out: out std_logic;
        TX: out std_logic_vector(31 downto 0);

        credit_out : out std_logic;
        valid_in: in std_logic;
        RX: in std_logic_vector(31 downto 0);
        uart_write  :out std_logic;
        uart_read   :in std_logic
   );
end component; --component NoC_Node


component sim_uart is
   generic(log_file : string := "UNUSED");
   port(clk          : in std_logic;
        reset        : in std_logic;
        enable_read  : in std_logic;
        enable_write : in std_logic;
        data_in      : in std_logic_vector(7 downto 0);
        data_out     : out std_logic_vector(7 downto 0);
        uart_read    : in std_logic;
        uart_write   : out std_logic;
        busy_write   : out std_logic;
        data_avail   : out std_logic;

        reg_enable            : in std_logic;
        reg_write_byte_enable : in std_logic_vector(3 downto 0);
        reg_address           : in std_logic_vector(31 downto 2);
        reg_data_write        : in std_logic_vector(31 downto 0);
        reg_data_read         : out std_logic_vector(31 downto 0)
        );
end component; --entity uart


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
	--------------
	constant clk_period : time := 10 ns;
	signal reset, not_reset, clk: std_logic :='0';

  --------------
  signal uart_0_data_in, uart_0_data_out,  uart_1_data_in, uart_1_data_out,  uart_2_data_in, uart_2_data_out,  uart_3_data_in, uart_3_data_out: std_logic_vector(7 downto 0);

  signal uart_0_enable_read, uart_0_enable_write, uart_0_busy_write, uart_0_data_avail, uart_0_reg_enable: std_logic;
  signal uart_1_enable_read, uart_1_enable_write, uart_1_busy_write, uart_1_data_avail, uart_1_reg_enable: std_logic;
  signal uart_2_enable_read, uart_2_enable_write, uart_2_busy_write, uart_2_data_avail, uart_2_reg_enable: std_logic;
  signal uart_3_enable_read, uart_3_enable_write, uart_3_busy_write, uart_3_data_avail, uart_3_reg_enable: std_logic;

  signal uart_0_reg_write_byte_enable, uart_1_reg_write_byte_enable, uart_2_reg_write_byte_enable, uart_3_reg_write_byte_enable : std_logic_vector(3 downto 0);

  signal  uart_0_reg_data_write, uart_0_reg_data_read, uart_1_reg_data_write, uart_1_reg_data_read, uart_2_reg_data_write, uart_2_reg_data_read, uart_3_reg_data_write, uart_3_reg_data_read: std_logic_vector(31 downto 0);
  signal uart_write_0,  uart_write_1, uart_write_2, uart_write_3: std_logic;
  signal uart_read_0,   uart_read_1,  uart_read_2,  uart_read_3: std_logic;

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

process(clk, reset)
  variable configure_uart : boolean := True;

begin
  if reset = '0' then
    uart_0_reg_write_byte_enable <= (others => '0');
    uart_0_reg_data_write <= (others => '0');
    uart_0_reg_enable <= '0';

    uart_1_reg_write_byte_enable <= (others => '0');
    uart_1_reg_data_write <= (others => '0');
    uart_1_reg_enable <= '0';

    uart_2_reg_write_byte_enable <= (others => '0');
    uart_2_reg_data_write <= (others => '0');
    uart_2_reg_enable <= '0';

    uart_3_reg_write_byte_enable <= (others => '0');
    uart_3_reg_data_write <= (others => '0');
    uart_3_reg_enable <= '0';

    uart_0_enable_read <= '0';
    uart_1_enable_read <= '0';
    uart_2_enable_read <= '0';
    uart_3_enable_read <= '0';
    uart_0_data_in <= (others => '0');
  elsif rising_edge(clk) then
    if configure_uart = True then
      uart_0_reg_write_byte_enable <= "1111";
      uart_0_reg_data_write <= "00000000000000000000000110110010";
      uart_0_reg_enable <= '1';

      uart_1_reg_write_byte_enable <= "1111";
      uart_1_reg_data_write <= "00000000000000000000000110110010";
      uart_1_reg_enable <= '1';

      uart_2_reg_write_byte_enable <= "1111";
      uart_2_reg_data_write <= "00000000000000000000000110110010";
      uart_2_reg_enable <= '1';

      uart_3_reg_write_byte_enable <= "1111";
      uart_3_reg_data_write <= "00000000000000000000000110110010";
      uart_3_reg_enable <= '1';

      configure_uart := False;
    else
      uart_0_enable_read <= '1';
      uart_1_enable_read <= '1';
      uart_2_enable_read <= '1';
      uart_3_enable_read <= '1';

      uart_0_reg_enable <= '0';
      uart_0_reg_write_byte_enable <= "0000";
      uart_0_reg_data_write <= "00000000000000000000000110110010";

      uart_1_reg_enable <= '0';
      uart_1_reg_write_byte_enable <= "0000";
      uart_1_reg_data_write <= "00000000000000000000000110110010";

      uart_2_reg_enable <= '0';
      uart_2_reg_write_byte_enable <= "0000";
      uart_2_reg_data_write <= "00000000000000000000000110110010";

      uart_3_reg_enable <= '0';
      uart_3_reg_write_byte_enable <= "0000";
      uart_3_reg_data_write <= "00000000000000000000000110110010";

      if now > 3 ms then
        uart_0_data_in <= uart_0_data_in + 1;
        uart_0_enable_write <= '1';
      end if;

    end if;
  end if;
end process;

-- connecting the PEs
PE_0: NoC_Node
generic map( current_address => 0,
	stim_file => "code_0.txt",
	log_file  => "output_0.txt")

port map( not_reset, clk,

        credit_in => credit_out_L_0,
        valid_out => valid_in_L_0,
        TX => RX_L_0,

        credit_out => credit_in_L_0,
        valid_in => valid_out_L_0,
        RX => TX_L_0,
        uart_write => uart_write_0,
        uart_read => uart_read_0
   );


   uart0: sim_uart generic map (log_file => "uart_0.txt") port map(

    clk          => clk,
    reset        => not_reset,
    enable_read  => uart_0_enable_read,
    enable_write => uart_0_enable_write,
    data_in      => uart_0_data_in,
    data_out     => uart_0_data_out,
    uart_read    => uart_write_0,
    uart_write   => uart_read_0,
    busy_write   => uart_0_busy_write,
    data_avail   => uart_0_data_avail,

    reg_enable            => uart_0_reg_enable ,
    reg_write_byte_enable => uart_0_reg_write_byte_enable,
    reg_address           => uart_count_value_address,
    reg_data_write        => uart_0_reg_data_write,
    reg_data_read         => uart_0_reg_data_read

  );

PE_1: NoC_Node
generic map( current_address => 1,
	stim_file => "code_1.txt",
	log_file  => "output_1.txt")

port map( not_reset, clk,

        credit_in => credit_out_L_1,
        valid_out => valid_in_L_1,
        TX => RX_L_1,

        credit_out => credit_in_L_1,
        valid_in => valid_out_L_1,
        RX => TX_L_1,
        uart_write => uart_write_1,
        uart_read => uart_read_1
   );

   uart1: sim_uart generic map (log_file => "uart_1.txt") port map(

    clk          => clk,
    reset        => not_reset,
    enable_read  => uart_1_enable_read,
    enable_write => uart_1_enable_write,
    data_in      => uart_1_data_in,
    data_out     => uart_1_data_out,
    uart_read    => uart_write_1,
    uart_write   => uart_read_1,
    busy_write   => uart_1_busy_write,
    data_avail   => uart_1_data_avail,

    reg_enable            => uart_1_reg_enable ,
    reg_write_byte_enable => uart_1_reg_write_byte_enable,
    reg_address           => uart_count_value_address,
    reg_data_write        => uart_1_reg_data_write,
    reg_data_read         => uart_1_reg_data_read

  );

PE_2: NoC_Node
generic map( current_address => 2,
	stim_file => "code_2.txt",
	log_file  => "output_2.txt")

port map( not_reset, clk,

        credit_in => credit_out_L_2,
        valid_out => valid_in_L_2,
        TX => RX_L_2,

        credit_out => credit_in_L_2,
        valid_in => valid_out_L_2,
        RX => TX_L_2,
        uart_write => uart_write_2,
        uart_read => uart_read_2
   );

   uart2: sim_uart generic map (log_file => "uart_2.txt") port map(

    clk          => clk,
    reset        => not_reset,
    enable_read  => uart_2_enable_read,
    enable_write => uart_2_enable_write,
    data_in      => uart_2_data_in,
    data_out     => uart_2_data_out,
    uart_read    => uart_write_2,
    uart_write   => uart_read_2,
    busy_write   => uart_2_busy_write,
    data_avail   => uart_2_data_avail,

    reg_enable            => uart_2_reg_enable ,
    reg_write_byte_enable => uart_2_reg_write_byte_enable,
    reg_address           => uart_count_value_address,
    reg_data_write        => uart_2_reg_data_write,
    reg_data_read         => uart_2_reg_data_read

  );

PE_3: NoC_Node
generic map( current_address => 3,
	stim_file => "code_3.txt",
	log_file  => "output_3.txt")

port map( not_reset, clk,

        credit_in => credit_out_L_3,
        valid_out => valid_in_L_3,
        TX => RX_L_3,

        credit_out => credit_in_L_3,
        valid_in => valid_out_L_3,
        RX => TX_L_3,
        uart_write => uart_write_3,
        uart_read => uart_read_3
   );

   uart3: sim_uart generic map (log_file => "uart_3.txt") port map(

    clk          => clk,
    reset        => not_reset,
    enable_read  => uart_3_enable_read,
    enable_write => uart_3_enable_write,
    data_in      => uart_3_data_in,
    data_out     => uart_3_data_out,
    uart_read    => uart_write_3,
    uart_write   => uart_read_3,
    busy_write   => uart_3_busy_write,
    data_avail   => uart_3_data_avail,

    reg_enable            => uart_3_reg_enable ,
    reg_write_byte_enable => uart_3_reg_write_byte_enable,
    reg_address           => uart_count_value_address,
    reg_data_write        => uart_3_reg_data_write,
    reg_data_read         => uart_3_reg_data_read

   );

-- connecting the packet generators


end;
