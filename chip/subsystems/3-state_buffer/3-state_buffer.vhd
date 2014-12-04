package IEEE;
use IEEE.std_logic_1164.all;

----------------------------------------------------------------------------------------------------
--Buffer A (BA)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_A is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic;
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_A is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe = '1') then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer In (Bin)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_in is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic;
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_in is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe = '1') then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 1 (B1)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_1 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_1 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=1)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 2 (B2)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_2 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_2 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=2)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 3 (B3)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_3 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_3 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=3)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 4 (B4)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_4 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_4 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=4)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 5 (B5)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_5 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_5 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=5)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
 
  ----------------------------------------------------------------------------------------------------
--Buffer 6 (B6)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_6 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_6 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=6)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 7 (B7)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_7 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_7 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=7)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 8 (B8)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_8 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_8 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=8)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 9 (B9)-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_9 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_9 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=9)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;

----------------------------------------------------------------------------------------------------
--Buffer 10 (B10)-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
entity buf_10 is
port( buf_in  : in  std_logic_vector(7 downto 0);
      buf_oe  : in  std_logic_vector(4 downto 0);
      buf_out : out std_logic_vector(7 downto 0));
end entity buffer;

architecture behaviour of buf_10 is
begin
  process (buf_in, buf_oe)
  begin
    if (buf_oe(4) = '1' AND (unsigned(buf_oe(3 downto 0))=10)) then
      buf_out <= buf_in;
    else
      buf_out <= "ZZZZZZZZ"
    end if;
  end process;
end architecture;