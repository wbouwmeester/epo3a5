library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sdcard is
port(	clk:			in std_logic;
		div_clk:		in std_logic; --between 100kHz and 400kHz
		reset:			in std_logic;
		address:		in std_logic_vector(31 downto 0);
		output:			out std_logic_vector(7 downto 0);
		busy_out:			out std_logic;
		
		sclk:			out std_logic;
		mosi:			out std_logic;
		miso:			out std_logic;
		ss:				out std_logic
	);
end entity sdcard;

architecture behavioural of sdcard is

	component spi is
	port (	clk		: in	std_logic;
		send		: in	std_logic;
		reset		: in	std_logic;
		write_enable	: in 	std_logic;
		write_in	: in	std_logic_vector (7 downto 0);
		read_out	: out	std_logic_vector (7 downto 0);
		busy		: out	std_logic;
		sclk		: out	std_logic;
		mosi		: out	std_logic;
		miso		: in	std_logic;
		ss			: out	std_logic
	);
	end component spi;

	type trans_state is (reset_state,dummy_count,dummy_send,init_cmd,init_send,init_read,init_receive,idle,load_cmd,send_part,read_response,receive_response,wait_data,read_data_part,read_data,buffer_data,error);
	signal state : trans_state;
	signal clk_switch : std_logic;
	signal send,write_enable,busy,mosi_spi,slave_select : std_logic;
	signal write_in : std_logic_vector(7 downto 0);
	signal output_reg,spi_output : std_logic_vector(7 downto 0);
	signal new_data,mosi_high,count_reset : std_logic;
	signal address_buf : std_logic_vector(31 downto 0);
	signal send_cnt,new_send_cnt : unsigned(3 downto 0);
begin

spi5:	spi port map(clk,send,reset,write_enable,write_in,spi_output,sclk,mosi_spi,miso,slave_select);
	output <= output_reg;
	
	new_data <= new_data when ((address_buf and address) = "00000000000000000000000000000000") else
				'1';

	mosi <= '1' when (mosi_high = '1') else
		mosi_spi;
	
	process(clk,reset)
		begin
		if(reset = '1') then
			state <= reset_state;
			address_buf <= (others => '0');
		else
			if rising_edge(clk)  then
				address_buf <= address;
				case state is 
					when reset_state =>
						if(reset = '0') then
							state <= dummy_count;
						else
							state <= reset_state;
						end if;
					when dummy_count =>
						if(send_cnt = "1000") then 
							state <= init_cmd;
						else
							state <= dummy_send;
						end if;
					when dummy_send =>
						if(busy = '0') then 
							state <= dummy_count;
						else
							state <= dummy_send;
						end if;
					when init_cmd =>
						if(send_cnt = "0110") then
							state <= init_read;
						else
							state <= init_send;
						end if;
					when init_send => 
						if(busy = '0') then
							state <= init_cmd;
						else
							state <= init_send;
						end if;
					when init_read => 
						if(spi_output = "00000000") then
							state <= idle;
						elsif(spi_output = "11111111") then
							state <= init_receive;
						else
							state <= error;
						end if;
					when init_receive =>
						if(busy = '0') then
							state <= init_read;
						else
							state <= init_receive;
						end if;
						
						-- TODO: set read length
						
					when idle =>
						if(new_data = '1') then
							state <= load_cmd;
						else
							state <= idle;
						end if;
					when load_cmd =>
						if(send_cnt = "0101") then
							state <= read_response;
						else
							state <= send_part;
						end if;
					when send_part =>
						if(busy = '0') then
							state <= load_cmd;
						else
							state <= send_part;
						end if;
					when read_response =>
						if(spi_output = "00000000") then
							state <= wait_data;
						elsif(spi_output = "11111111") then
							state <= receive_response;
						else
							state <= error;
						end if;
					when receive_response =>
						if(busy = '0') then
							state <= read_response;
						else
							state <= receive_response;
						end if;
					when wait_data =>
						if(spi_output = "11111110") then
							state <= read_data;
						else
							state <= read_data_part;
						end if;
					when read_data_part =>
						if(busy = '0') then
							state <= wait_data;
						else
							state <= read_data_part;
						end if;
					when read_data =>
						if(busy = '0') then
							state <= buffer_data;
						else
							state <= read_data;
						end if;
					when buffer_data =>
						state <= idle;
					when error =>
						state <= error;
				end case;	
			end if;	
		end if;
	end process;
	
	process(state)
	begin
		case state is 
			when reset_state =>
				slave_select <= '1';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";
			when dummy_count =>
				slave_select <= '1';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= send_cnt + 1;
				write_in <= "11111111";
			when dummy_send =>
				slave_select <= '1';
				mosi_high <= '1';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";
			when init_cmd =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '1';
				new_send_cnt <= send_cnt + 1;
				case send_cnt is
					when "0000" =>
						write_in <= "01000000";
					when "0001" =>
						write_in <= "00000000";
					when "0010" =>
						write_in <= "00000000";
					when "0011" =>
						write_in <= "00000000";
					when "0100" =>
						write_in <= "00000000";
					when "0101" =>
						write_in <= "10010101";
					when "0110" =>
						write_in <= "11111111";
					when others =>
						write_in <= "01000010";
				end case;
			when init_send =>
				slave_select <= '0';
				mosi_high <= '0';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when init_read =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when init_receive =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when idle =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when load_cmd =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '1';
				new_send_cnt <= send_cnt + 1;
				case send_cnt is
					when "0000" =>
						write_in <= "01010001";
					when "0001" =>
						write_in <= address(31 downto 24);
					when "0010" =>
						write_in <= address(23 downto 16);
					when "0011" =>
						write_in <= address(15 downto 8);
					when "0100" =>
						write_in <= address(7 downto 0);
					when "0101" =>
						write_in <= "11111111";
					when others =>
						write_in <= "01000010";
				end case;
			when send_part =>
				slave_select <= '0';
				mosi_high <= '0';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= send_cnt;
				write_in <= "11111111";
			when read_response =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= send_cnt;
				write_in <= "11111111";
			when receive_response =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when wait_data =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= send_cnt;
				write_in <= "11111111";
			when read_data_part =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when read_data =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '1';
				write_enable <= '0';
				new_send_cnt <= send_cnt;
				write_in <= "11111111";
			when buffer_data =>
				slave_select <= '0';
				mosi_high <= '1';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
			when error =>
				slave_select <= '0';
				mosi_high <= '0';
				send <= '0';
				write_enable <= '0';
				new_send_cnt <= (others => '0');
				write_in <= "11111111";	
		end case;
	end process;
	
	process(clk,count_reset)
	begin
		if(count_reset = '1') then
			send_cnt <= (others => '0');
		else
			if(rising_edge(clk)) then
				send_cnt <= new_send_cnt;
			end if;
		end if;
	end process;

end behavioural;
