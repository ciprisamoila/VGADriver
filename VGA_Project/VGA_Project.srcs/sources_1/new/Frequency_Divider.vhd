library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Frequency_Divider is
    Port ( CLK : in STD_LOGIC; --100MHz
           RST : in STD_LOGIC;
           PIXEL_CLK : out STD_LOGIC); -- 25MHz
end Frequency_Divider;

architecture Behavioral of Frequency_Divider is

    signal count : std_logic_vector (1 downto 0) := (others => '0');  -- PIXEL_CLK is the division of board's CLK by 4
    
    begin
    
        process(CLK) 
            begin
                if rising_edge(CLK) then
                    if RST = '1' then
                        count <= (others => '0');
                    else
                        count <= count + 1;
                    end if;
                end if;
            end process;
            
        PIXEL_CLK <= count(1); -- only take in account the MSB of the counting value, in order to have a cycle duty of 50%
     
end Behavioral;