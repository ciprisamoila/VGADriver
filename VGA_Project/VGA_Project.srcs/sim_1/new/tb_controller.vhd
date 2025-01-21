library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_controller is
--  Port ( );
end tb_controller;

architecture Behavioral of tb_controller is
component VGA_controller is
    Port ( CLK : in STD_LOGIC; -- pixel clock
           RST : in STD_LOGIC; -- reset, active high
           HS : out STD_LOGIC; -- horizontal sync
           VS : out STD_LOGIC; -- vertical sync
           HP : out STD_LOGIC_VECTOR (9 downto 0); -- horizontal position
           VP : out STD_LOGIC_VECTOR (9 downto 0); -- vertical position
           video_on: out STD_LOGIC);
end component;
signal clk, rst, hs, vs, video_on : std_logic;
signal hp, vp : std_logic_vector (9 downto 0);
begin
    TB: VGA_controller port map (clk, rst, hs, vs, hp, vp, video_on);
    
    clk_gen: process
    begin
        if clk = 'U' then clk <= '0';
        else clk <= not clk;
        end if;
        wait for 1 ps;
    end process;
    
    --rst <= '0', '1' after 10 ns, '0' after 20 ns;

end Behavioral;
