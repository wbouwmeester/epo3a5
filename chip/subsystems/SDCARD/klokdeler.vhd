library IEEE;
use IEEE.std_logic_1164.ALL;

entity klokdeler is
   port(clk     :in    std_logic;
        f2     :out   std_logic;
        f4     :out   std_logic;
        f8     :out   std_logic;
        f16    :out   std_logic;
        f32    :out   std_logic;
        f64    :out   std_logic;
        f128   :out   std_logic;
        f256   :out   std_logic;
        f512   :out   std_logic;
        f1024  :out   std_logic;
        f2048  :out   std_logic;
        f4096  :out   std_logic;
        f8192  :out   std_logic;
        f16384 :out   std_logic;
        f32768 :out   std_logic;
        f65536 :out   std_logic;
        f131072:out   std_logic;
reset: in std_logic);
end klokdeler;

architecture behavioural of klokdeler is
signal d2, d4, d8, d16, d32, d64, d128, d256, d512, d1024, d2048, d4096, d8192, d16384, d32768, d65536, d131072 : std_logic := '1';

component dff_capabel is
port ( q, qbar: out std_logic; clk, d, reset: in std_logic);
end component;

begin
lbl1: dff_capabel port map(f2, d2, clk, d2,reset);
lbl2: dff_capabel port map(f4, d4, d2, d4,reset);
lbl3: dff_capabel port map(f8, d8, d4, d8,reset);
lbl4: dff_capabel port map(f16, d16, d8, d16,reset);
lbl5: dff_capabel port map(f32, d32, d16, d32,reset);
lbl6: dff_capabel port map(f64, d64, d32, d64,reset);
lbl7: dff_capabel port map(f128, d128, d64, d128,reset);
lbl8: dff_capabel port map(f256, d256, d128, d256,reset);
lbl9: dff_capabel port map(f512, d512, d256, d512,reset);
lbl10: dff_capabel port map(f1024, d1024, d512, d1024,reset);
lbl11: dff_capabel port map(f2048, d2048, d1024, d2048,reset);
lbl12: dff_capabel port map(f4096, d4096, d2048, d4096,reset);
lbl13: dff_capabel port map(f8192, d8192, d4096, d8192,reset);
lbl14: dff_capabel port map(f16384, d16384, d8192, d16384,reset);
lbl15: dff_capabel port map(f32768, d32768, d16384, d32768,reset);
lbl16: dff_capabel port map(f65536, d65536, d32768, d65536,reset);
lbl17: dff_capabel port map(f131072, d131072, d65536, d131072,reset);

end behavioural;


















































































