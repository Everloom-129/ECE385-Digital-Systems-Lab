	component lab7_spc is
		port (
			clk_clk                          : in  std_logic                    := 'X'; -- clk
			pio_0_external_connection_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component lab7_spc;

	u0 : component lab7_spc
		port map (
			clk_clk                          => CONNECTED_TO_clk_clk,                          --                       clk.clk
			pio_0_external_connection_export => CONNECTED_TO_pio_0_external_connection_export  -- pio_0_external_connection.export
		);

