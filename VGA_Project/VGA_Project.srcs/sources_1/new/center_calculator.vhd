library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- computes the coordinates of the center of the figures
entity center_calculator is
    Port ( BTN_UP : in STD_LOGIC;
           BTN_DOWN : in STD_LOGIC;
           BTN_LEFT : in STD_LOGIC;
           BTN_RIGHT : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           centerH : out STD_LOGIC_VECTOR (9 downto 0);
           centerV : out STD_LOGIC_VECTOR (9 downto 0));
end center_calculator;

architecture Behavioral of center_calculator is
component Debouncer is
    Port ( CLK100 : in STD_LOGIC;
           RST : in STD_LOGIC;
           BTN : in STD_LOGIC;
           BTN_DEB : out STD_LOGIC);
end component;

constant CH : STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(to_unsigned(320, 10)); -- center of display
constant CV : STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(to_unsigned(240, 10));

constant size : integer := 100; -- size of figures

signal countH : STD_LOGIC_VECTOR (9 downto 0) := CH; -- coordinates of the center of figure
signal countV : STD_LOGIC_VECTOR (9 downto 0) := CV;

signal UP, DOWN, RIGHT, LEFT : std_logic; -- debounced buttons

signal count : std_logic_vector (19 downto 0) := (others => '0');

signal CLK_NEW : std_logic;

begin

    divider: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                count <= (others => '0');
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    CLK_NEW <= count(19); -- divided clock

    -- Debouncer for each input button 
    P1: Debouncer port map (CLK100 => CLK, RST => RST, BTN => BTN_UP, BTN_DEB => UP);
    P2: Debouncer port map (CLK100 => CLK, RST => RST, BTN => BTN_DOWN, BTN_DEB => DOWN);
    P3: Debouncer port map (CLK100 => CLK, RST => RST, BTN => BTN_LEFT, BTN_DEB => LEFT);
    P4: Debouncer port map (CLK100 => CLK, RST => RST, BTN => BTN_RIGHT, BTN_DEB => RIGHT);
    
    process(CLK_NEW)
    begin
        if RST = '1' then
            countH <= CH;
            countV <= CV;
        elsif rising_edge(CLK_NEW) then
            
            -- Update central position based on button input
        
            if UP = '1' and countV - size >= 1 then
                countV <= countV - 1;
            end if;
            if DOWN = '1' and countV + size + 1 <= 480 then
                countV <= countV + 1;
            end if;
            if RIGHT = '1' and countH + size + 1 <= 640 then
                countH <= countH + 1;
            end if;
            if LEFT = '1' and countH - size >= 1 then
                countH <= countH - 1;
            end if;
        end if;
    end process;
    
    centerH <= countH;
    centerV <= countV;

end Behavioral;