--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : lab3_reg_file.vhf
-- /___/   /\     Timestamp : 09/10/2017 22:19:26
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family artix7 -flat -suppress -vhdl /home/kgopal/lab3_reg_file/lab3_reg_file.vhf -w /home/kgopal/lab3_reg_file/lab3_reg_file.sch
--Design Name: lab3_reg_file
--Device: artix7
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL M8_1E_HXILINX_lab3_reg_file -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity M8_1E_HXILINX_lab3_reg_file is
  
port(
    O   : out std_logic;

    D0  : in std_logic;
    D1  : in std_logic;
    D2  : in std_logic;
    D3  : in std_logic;
    D4  : in std_logic;
    D5  : in std_logic;
    D6  : in std_logic;
    D7  : in std_logic;
    E   : in std_logic;
    S0  : in std_logic;
    S1  : in std_logic;
    S2  : in std_logic
  );
end M8_1E_HXILINX_lab3_reg_file;

architecture M8_1E_HXILINX_lab3_reg_file_V of M8_1E_HXILINX_lab3_reg_file is
begin
  process (D0, D1, D2, D3, D4, D5, D6, D7, E, S0, S1, S2)
  variable sel : std_logic_vector(2 downto 0);
  begin
    sel := S2&S1&S0;
    if( E = '0') then
    O <= '0';
    else
      case sel is
      when "000" => O <= D0;
      when "001" => O <= D1;
      when "010" => O <= D2;
      when "011" => O <= D3;
      when "100" => O <= D4;
      when "101" => O <= D5;
      when "110" => O <= D6;
      when "111" => O <= D7;
      when others => NULL;
      end case;
    end if;
    end process; 
end M8_1E_HXILINX_lab3_reg_file_V;
----- CELL D3_8E_HXILINX_lab3_reg_file -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D3_8E_HXILINX_lab3_reg_file is
  
port(
    D0  : out std_logic;
    D1  : out std_logic;
    D2  : out std_logic;
    D3  : out std_logic;
    D4  : out std_logic;
    D5  : out std_logic;
    D6  : out std_logic;
    D7  : out std_logic;

    A0  : in std_logic;
    A1  : in std_logic;
    A2  : in std_logic;
    E   : in std_logic
  );
end D3_8E_HXILINX_lab3_reg_file;

architecture D3_8E_HXILINX_lab3_reg_file_V of D3_8E_HXILINX_lab3_reg_file is
  signal d_tmp : std_logic_vector(7 downto 0);
begin
  process (A0, A1, A2, E)
  variable sel   : std_logic_vector(2 downto 0);
  begin
    sel := A2&A1&A0;
    if( E = '0') then
    d_tmp <= "00000000";
    else
      case sel is
      when "000" => d_tmp <= "00000001";
      when "001" => d_tmp <= "00000010";
      when "010" => d_tmp <= "00000100";
      when "011" => d_tmp <= "00001000";
      when "100" => d_tmp <= "00010000";
      when "101" => d_tmp <= "00100000";
      when "110" => d_tmp <= "01000000";
      when "111" => d_tmp <= "10000000";
      when others => NULL;
      end case;
    end if;
  end process; 

    D7 <= d_tmp(7);
    D6 <= d_tmp(6);
    D5 <= d_tmp(5);
    D4 <= d_tmp(4);
    D3 <= d_tmp(3);
    D2 <= d_tmp(2);
    D1 <= d_tmp(1);
    D0 <= d_tmp(0);

end D3_8E_HXILINX_lab3_reg_file_V;
----- CELL M2_1_HXILINX_lab3_reg_file -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity M2_1_HXILINX_lab3_reg_file is
  
port(
    O   : out std_logic;

    D0  : in std_logic;
    D1  : in std_logic;
    S0  : in std_logic
  );
end M2_1_HXILINX_lab3_reg_file;

architecture M2_1_HXILINX_lab3_reg_file_V of M2_1_HXILINX_lab3_reg_file is
begin
  process (D0, D1, S0)
  begin
    case S0 is
    when '0' => O <= D0;
    when '1' => O <= D1;
    when others => NULL;
    end case;
    end process; 
end M2_1_HXILINX_lab3_reg_file_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity aman1_MUSER_lab3_reg_file is
   port ( e  : in    std_logic; 
          R1 : in    std_logic_vector (3 downto 0); 
          R2 : in    std_logic_vector (3 downto 0); 
          R3 : in    std_logic_vector (3 downto 0); 
          R4 : in    std_logic_vector (3 downto 0); 
          R5 : in    std_logic_vector (3 downto 0); 
          R6 : in    std_logic_vector (3 downto 0); 
          R7 : in    std_logic_vector (3 downto 0); 
          R8 : in    std_logic_vector (3 downto 0); 
          S  : in    std_logic_vector (2 downto 0); 
          t  : out   std_logic_vector (3 downto 0));
end aman1_MUSER_lab3_reg_file;

architecture BEHAVIORAL of aman1_MUSER_lab3_reg_file is
   attribute HU_SET     : string ;
   component M8_1E_HXILINX_lab3_reg_file
      port ( D0 : in    std_logic; 
             D1 : in    std_logic; 
             D2 : in    std_logic; 
             D3 : in    std_logic; 
             D4 : in    std_logic; 
             D5 : in    std_logic; 
             D6 : in    std_logic; 
             D7 : in    std_logic; 
             E  : in    std_logic; 
             S0 : in    std_logic; 
             S1 : in    std_logic; 
             S2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   attribute HU_SET of XLXI_9 : label is "XLXI_9_4";
   attribute HU_SET of XLXI_10 : label is "XLXI_10_5";
   attribute HU_SET of XLXI_11 : label is "XLXI_11_6";
   attribute HU_SET of XLXI_12 : label is "XLXI_12_7";
begin
   XLXI_9 : M8_1E_HXILINX_lab3_reg_file
      port map (D0=>R1(0),
                D1=>R2(0),
                D2=>R3(0),
                D3=>R4(0),
                D4=>R5(0),
                D5=>R6(0),
                D6=>R7(0),
                D7=>R8(0),
                E=>e,
                S0=>S(0),
                S1=>S(1),
                S2=>S(2),
                O=>t(0));
   
   XLXI_10 : M8_1E_HXILINX_lab3_reg_file
      port map (D0=>R1(2),
                D1=>R2(2),
                D2=>R3(2),
                D3=>R4(2),
                D4=>R5(2),
                D5=>R6(2),
                D6=>R7(2),
                D7=>R8(2),
                E=>e,
                S0=>S(0),
                S1=>S(1),
                S2=>S(2),
                O=>t(2));
   
   XLXI_11 : M8_1E_HXILINX_lab3_reg_file
      port map (D0=>R1(1),
                D1=>R2(1),
                D2=>R3(1),
                D3=>R4(1),
                D4=>R5(1),
                D5=>R6(1),
                D6=>R7(1),
                D7=>R8(1),
                E=>e,
                S0=>S(0),
                S1=>S(1),
                S2=>S(2),
                O=>t(1));
   
   XLXI_12 : M8_1E_HXILINX_lab3_reg_file
      port map (D0=>R1(3),
                D1=>R2(3),
                D2=>R3(3),
                D3=>R4(3),
                D4=>R5(3),
                D5=>R6(3),
                D6=>R7(3),
                D7=>R8(3),
                E=>e,
                S0=>S(0),
                S1=>S(1),
                S2=>S(2),
                O=>t(3));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity mux_4_bit_MUSER_lab3_reg_file is
   port ( d1   : in    std_logic_vector (3 downto 0); 
          d2   : in    std_logic_vector (3 downto 0); 
          mode : in    std_logic; 
          o    : out   std_logic_vector (3 downto 0));
end mux_4_bit_MUSER_lab3_reg_file;

architecture BEHAVIORAL of mux_4_bit_MUSER_lab3_reg_file is
   attribute HU_SET     : string ;
   component M2_1_HXILINX_lab3_reg_file
      port ( D0 : in    std_logic; 
             D1 : in    std_logic; 
             S0 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   attribute HU_SET of XLXI_1 : label is "XLXI_1_8";
   attribute HU_SET of XLXI_2 : label is "XLXI_2_9";
   attribute HU_SET of XLXI_3 : label is "XLXI_3_10";
   attribute HU_SET of XLXI_4 : label is "XLXI_4_11";
begin
   XLXI_1 : M2_1_HXILINX_lab3_reg_file
      port map (D0=>d1(0),
                D1=>d2(0),
                S0=>mode,
                O=>o(0));
   
   XLXI_2 : M2_1_HXILINX_lab3_reg_file
      port map (D0=>d1(1),
                D1=>d2(1),
                S0=>mode,
                O=>o(1));
   
   XLXI_3 : M2_1_HXILINX_lab3_reg_file
      port map (D0=>d1(2),
                D1=>d2(2),
                S0=>mode,
                O=>o(2));
   
   XLXI_4 : M2_1_HXILINX_lab3_reg_file
      port map (D0=>d1(3),
                D1=>d2(3),
                S0=>mode,
                O=>o(3));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity xor_data_MUSER_lab3_reg_file is
   port ( data1 : in    std_logic_vector (3 downto 0); 
          data2 : in    std_logic_vector (3 downto 0); 
          x     : out   std_logic_vector (3 downto 0));
end xor_data_MUSER_lab3_reg_file;

architecture BEHAVIORAL of xor_data_MUSER_lab3_reg_file is
   attribute BOX_TYPE   : string ;
   component XOR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of XOR2 : component is "BLACK_BOX";
   
begin
   XLXI_1 : XOR2
      port map (I0=>data2(0),
                I1=>data1(0),
                O=>x(0));
   
   XLXI_2 : XOR2
      port map (I0=>data2(1),
                I1=>data1(1),
                O=>x(1));
   
   XLXI_3 : XOR2
      port map (I0=>data2(2),
                I1=>data1(2),
                O=>x(2));
   
   XLXI_4 : XOR2
      port map (I0=>data2(3),
                I1=>data1(3),
                O=>x(3));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity register23_MUSER_lab3_reg_file is
   port ( clock : in    std_logic; 
          d     : in    std_logic_vector (3 downto 0); 
          q     : out   std_logic_vector (3 downto 0));
end register23_MUSER_lab3_reg_file;

architecture BEHAVIORAL of register23_MUSER_lab3_reg_file is
   attribute BOX_TYPE   : string ;
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
begin
   XLXI_1 : FD
      port map (C=>clock,
                D=>d(0),
                Q=>q(0));
   
   XLXI_2 : FD
      port map (C=>clock,
                D=>d(1),
                Q=>q(1));
   
   XLXI_3 : FD
      port map (C=>clock,
                D=>d(2),
                Q=>q(2));
   
   XLXI_4 : FD
      port map (C=>clock,
                D=>d(3),
                Q=>q(3));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity lab3_reg_file is
   port ( clock              : in    std_logic; 
          mode               : in    std_logic; 
          rd_addr1           : in    std_logic_vector (2 downto 0); 
          rd_addr2           : in    std_logic_vector (2 downto 0); 
          write_enable       : in    std_logic; 
          wr_addr            : in    std_logic_vector (2 downto 0); 
          wr_data            : in    std_logic_vector (3 downto 0); 
          rd_data1           : out   std_logic_vector (3 downto 0); 
          rd_data1_xor_data2 : out   std_logic_vector (3 downto 0); 
          rd_data2           : out   std_logic_vector (3 downto 0));
end lab3_reg_file;

architecture BEHAVIORAL of lab3_reg_file is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal XLXN_53                  : std_logic;
   signal XLXN_86                  : std_logic;
   signal XLXN_87                  : std_logic;
   signal XLXN_88                  : std_logic;
   signal XLXN_89                  : std_logic;
   signal XLXN_90                  : std_logic;
   signal XLXN_91                  : std_logic;
   signal XLXN_92                  : std_logic;
   signal XLXN_93                  : std_logic;
   signal XLXN_102                 : std_logic;
   signal XLXN_103                 : std_logic;
   signal XLXN_104                 : std_logic;
   signal XLXN_105                 : std_logic;
   signal XLXN_106                 : std_logic;
   signal XLXN_107                 : std_logic;
   signal XLXN_108                 : std_logic;
   signal XLXN_110                 : std_logic;
   signal XLXN_122                 : std_logic_vector (3 downto 0);
   signal XLXN_132                 : std_logic_vector (3 downto 0);
   signal XLXN_133                 : std_logic_vector (3 downto 0);
   signal XLXN_134                 : std_logic_vector (3 downto 0);
   signal XLXN_135                 : std_logic_vector (3 downto 0);
   signal XLXN_136                 : std_logic_vector (3 downto 0);
   signal XLXN_137                 : std_logic_vector (3 downto 0);
   signal XLXN_139                 : std_logic_vector (3 downto 0);
   signal XLXN_141                 : std_logic_vector (3 downto 0);
   signal rd_data1_DUMMY           : std_logic_vector (3 downto 0);
   signal rd_data2_DUMMY           : std_logic_vector (3 downto 0);
   signal rd_data1_xor_data2_DUMMY : std_logic_vector (3 downto 0);
   component register23_MUSER_lab3_reg_file
      port ( d     : in    std_logic_vector (3 downto 0); 
             clock : in    std_logic; 
             q     : out   std_logic_vector (3 downto 0));
   end component;
   
   component D3_8E_HXILINX_lab3_reg_file
      port ( A0 : in    std_logic; 
             A1 : in    std_logic; 
             A2 : in    std_logic; 
             E  : in    std_logic; 
             D0 : out   std_logic; 
             D1 : out   std_logic; 
             D2 : out   std_logic; 
             D3 : out   std_logic; 
             D4 : out   std_logic; 
             D5 : out   std_logic; 
             D6 : out   std_logic; 
             D7 : out   std_logic);
   end component;
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component xor_data_MUSER_lab3_reg_file
      port ( data1 : in    std_logic_vector (3 downto 0); 
             data2 : in    std_logic_vector (3 downto 0); 
             x     : out   std_logic_vector (3 downto 0));
   end component;
   
   component mux_4_bit_MUSER_lab3_reg_file
      port ( d1   : in    std_logic_vector (3 downto 0); 
             d2   : in    std_logic_vector (3 downto 0); 
             mode : in    std_logic; 
             o    : out   std_logic_vector (3 downto 0));
   end component;
   
   component aman1_MUSER_lab3_reg_file
      port ( e  : in    std_logic; 
             R1 : in    std_logic_vector (3 downto 0); 
             R2 : in    std_logic_vector (3 downto 0); 
             R3 : in    std_logic_vector (3 downto 0); 
             R4 : in    std_logic_vector (3 downto 0); 
             R5 : in    std_logic_vector (3 downto 0); 
             R6 : in    std_logic_vector (3 downto 0); 
             R7 : in    std_logic_vector (3 downto 0); 
             R8 : in    std_logic_vector (3 downto 0); 
             S  : in    std_logic_vector (2 downto 0); 
             t  : out   std_logic_vector (3 downto 0));
   end component;
   
   attribute HU_SET of XLXI_37 : label is "XLXI_37_12";
begin
   XLXN_53 <= '1';
   rd_data1(3 downto 0) <= rd_data1_DUMMY(3 downto 0);
   rd_data1_xor_data2(3 downto 0) <= rd_data1_xor_data2_DUMMY(3 downto 0);
   rd_data2(3 downto 0) <= rd_data2_DUMMY(3 downto 0);
   XLXI_22 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_86,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_132(3 downto 0));
   
   XLXI_23 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_87,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_133(3 downto 0));
   
   XLXI_24 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_88,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_134(3 downto 0));
   
   XLXI_25 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_89,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_135(3 downto 0));
   
   XLXI_26 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_90,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_136(3 downto 0));
   
   XLXI_27 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_91,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_137(3 downto 0));
   
   XLXI_28 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_92,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_139(3 downto 0));
   
   XLXI_29 : register23_MUSER_lab3_reg_file
      port map (clock=>XLXN_93,
                d(3 downto 0)=>XLXN_122(3 downto 0),
                q(3 downto 0)=>XLXN_141(3 downto 0));
   
   XLXI_37 : D3_8E_HXILINX_lab3_reg_file
      port map (A0=>wr_addr(0),
                A1=>wr_addr(1),
                A2=>wr_addr(2),
                E=>write_enable,
                D0=>XLXN_102,
                D1=>XLXN_103,
                D2=>XLXN_104,
                D3=>XLXN_105,
                D4=>XLXN_106,
                D5=>XLXN_107,
                D6=>XLXN_108,
                D7=>XLXN_110);
   
   XLXI_46 : AND2
      port map (I0=>clock,
                I1=>XLXN_102,
                O=>XLXN_86);
   
   XLXI_50 : AND2
      port map (I0=>clock,
                I1=>XLXN_103,
                O=>XLXN_87);
   
   XLXI_51 : AND2
      port map (I0=>clock,
                I1=>XLXN_104,
                O=>XLXN_88);
   
   XLXI_52 : AND2
      port map (I0=>clock,
                I1=>XLXN_105,
                O=>XLXN_89);
   
   XLXI_53 : AND2
      port map (I0=>clock,
                I1=>XLXN_106,
                O=>XLXN_90);
   
   XLXI_54 : AND2
      port map (I0=>clock,
                I1=>XLXN_107,
                O=>XLXN_91);
   
   XLXI_55 : AND2
      port map (I0=>clock,
                I1=>XLXN_108,
                O=>XLXN_92);
   
   XLXI_56 : AND2
      port map (I0=>clock,
                I1=>XLXN_110,
                O=>XLXN_93);
   
   XLXI_57 : xor_data_MUSER_lab3_reg_file
      port map (data1(3 downto 0)=>rd_data1_DUMMY(3 downto 0),
                data2(3 downto 0)=>rd_data2_DUMMY(3 downto 0),
                x(3 downto 0)=>rd_data1_xor_data2_DUMMY(3 downto 0));
   
   XLXI_58 : mux_4_bit_MUSER_lab3_reg_file
      port map (d1(3 downto 0)=>wr_data(3 downto 0),
                d2(3 downto 0)=>rd_data1_xor_data2_DUMMY(3 downto 0),
                mode=>mode,
                o(3 downto 0)=>XLXN_122(3 downto 0));
   
   XLXI_66 : aman1_MUSER_lab3_reg_file
      port map (e=>XLXN_53,
                R1(3 downto 0)=>XLXN_132(3 downto 0),
                R2(3 downto 0)=>XLXN_133(3 downto 0),
                R3(3 downto 0)=>XLXN_134(3 downto 0),
                R4(3 downto 0)=>XLXN_135(3 downto 0),
                R5(3 downto 0)=>XLXN_136(3 downto 0),
                R6(3 downto 0)=>XLXN_137(3 downto 0),
                R7(3 downto 0)=>XLXN_139(3 downto 0),
                R8(3 downto 0)=>XLXN_141(3 downto 0),
                S(2 downto 0)=>rd_addr2(2 downto 0),
                t(3 downto 0)=>rd_data2_DUMMY(3 downto 0));
   
   XLXI_67 : aman1_MUSER_lab3_reg_file
      port map (e=>XLXN_53,
                R1(3 downto 0)=>XLXN_132(3 downto 0),
                R2(3 downto 0)=>XLXN_133(3 downto 0),
                R3(3 downto 0)=>XLXN_134(3 downto 0),
                R4(3 downto 0)=>XLXN_135(3 downto 0),
                R5(3 downto 0)=>XLXN_136(3 downto 0),
                R6(3 downto 0)=>XLXN_137(3 downto 0),
                R7(3 downto 0)=>XLXN_139(3 downto 0),
                R8(3 downto 0)=>XLXN_141(3 downto 0),
                S(2 downto 0)=>rd_addr1(2 downto 0),
                t(3 downto 0)=>rd_data1_DUMMY(3 downto 0));
   
end BEHAVIORAL;


