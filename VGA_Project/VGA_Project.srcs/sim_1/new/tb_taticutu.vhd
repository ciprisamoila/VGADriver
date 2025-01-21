library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Tester is
--  Port ( );
end tb_Tester;

architecture Behavioral of tb_Tester is
component Tester is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           HS : out STD_LOGIC;
           VS : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal clk, rst, hs, vs : std_logic;
signal r, g, b : std_logic_vector (3 downto 0);
begin
    Q: Tester port map (clk, rst, hs, vs, r, g, b);
    
    clk_gen: process
    begin
        if clk = 'U' then clk <= '0';
        else clk <= not clk;
        end if;
        wait for 1 ps;
    end process;
    
    rst <= '0', '1' after 10 ps, '0' after 20 ps;

end Behavioral;
