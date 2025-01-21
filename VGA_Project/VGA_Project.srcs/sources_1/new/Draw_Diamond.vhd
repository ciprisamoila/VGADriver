library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Draw_Diamond is
        Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
             VP: in STD_LOGIC_VECTOR(9 downto 0);
             centerH : in STD_LOGIC_VECTOR (9 downto 0);
             centerV : in STD_LOGIC_VECTOR (9 downto 0);
             draw: out STD_LOGIC);
end Draw_Diamond;

architecture Behavioral of Draw_Diamond is

    constant max_distance : integer := 100; -- Distance from center in Taxicab metric

begin

    process
    
        variable HP_int: integer;
        variable centerH_int: integer;
        variable VP_int: integer;
        variable centerV_int: integer;
        variable distance : integer;
    
        begin
        
            HP_int := to_integer(unsigned(HP));
            centerH_int := to_integer(unsigned(centerH));
            VP_int := to_integer(unsigned(VP));
            centerV_int := to_integer(unsigned(centerV));
            
            -- Created using the Eulerian metric
            distance := abs(HP_int - centerH_int) + abs(VP_int - centerV_int);

            if distance <= max_distance then
                draw <= '1';
            else
                draw <= '0';
            end if;
        
        end process;
end Behavioral;