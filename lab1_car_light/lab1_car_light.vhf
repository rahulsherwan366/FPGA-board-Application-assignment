--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : lab1_car_light.vhf
-- /___/   /\     Timestamp : 08/13/2017 16:13:09
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family artix7 -flat -suppress -vhdl /home/kgopal/lab1_car_light/lab1_car_light.vhf -w /home/kgopal/lab1_car_light/lab1_car_light.sch
--Design Name: lab1_car_light
--Device: artix7
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity lab1_car_light is
   port ( D1      : in    std_logic; 
          D2      : in    std_logic; 
          D3      : in    std_logic; 
          D4      : in    std_logic; 
          SW_DOOR : in    std_logic; 
          SW_OFF  : in    std_logic; 
          SW_ON   : in    std_logic; 
          INVALID : out   std_logic; 
          LIGHT   : out   std_logic);
end lab1_car_light;

architecture BEHAVIORAL of lab1_car_light is
   attribute BOX_TYPE   : string ;
   signal XLXN_16 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_21 : std_logic;
   signal XLXN_22 : std_logic;
   signal XLXN_23 : std_logic;
   signal XLXN_24 : std_logic;
   signal XLXN_25 : std_logic;
   signal XLXN_28 : std_logic;
   signal XLXN_29 : std_logic;
   signal XLXN_30 : std_logic;
   signal XLXN_31 : std_logic;
   signal XLXN_32 : std_logic;
   signal XLXN_33 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component NAND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of NAND2 : component is "BLACK_BOX";
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
begin
   XLXI_2 : AND2
      port map (I0=>SW_DOOR,
                I1=>XLXN_16,
                O=>XLXN_19);
   
   XLXI_3 : OR4
      port map (I0=>D4,
                I1=>D3,
                I2=>D2,
                I3=>D1,
                O=>XLXN_16);
   
   XLXI_4 : AND2
      port map (I0=>XLXN_18,
                I1=>XLXN_19,
                O=>XLXN_23);
   
   XLXI_5 : OR2
      port map (I0=>XLXN_22,
                I1=>XLXN_23,
                O=>XLXN_24);
   
   XLXI_6 : INV
      port map (I=>SW_OFF,
                O=>XLXN_18);
   
   XLXI_7 : INV
      port map (I=>SW_OFF,
                O=>XLXN_21);
   
   XLXI_8 : AND2
      port map (I0=>SW_ON,
                I1=>XLXN_21,
                O=>XLXN_22);
   
   XLXI_9 : NAND2
      port map (I0=>SW_ON,
                I1=>SW_DOOR,
                O=>XLXN_25);
   
   XLXI_10 : AND2
      port map (I0=>XLXN_24,
                I1=>XLXN_25,
                O=>LIGHT);
   
   XLXI_11 : OR3
      port map (I0=>XLXN_31,
                I1=>SW_OFF,
                I2=>SW_DOOR,
                O=>XLXN_28);
   
   XLXI_12 : OR3
      port map (I0=>SW_ON,
                I1=>XLXN_32,
                I2=>SW_DOOR,
                O=>XLXN_29);
   
   XLXI_13 : OR3
      port map (I0=>SW_ON,
                I1=>SW_OFF,
                I2=>XLXN_33,
                O=>XLXN_30);
   
   XLXI_14 : AND3
      port map (I0=>XLXN_30,
                I1=>XLXN_29,
                I2=>XLXN_28,
                O=>INVALID);
   
   XLXI_15 : INV
      port map (I=>SW_ON,
                O=>XLXN_31);
   
   XLXI_16 : INV
      port map (I=>SW_OFF,
                O=>XLXN_32);
   
   XLXI_17 : INV
      port map (I=>SW_DOOR,
                O=>XLXN_33);
   
end BEHAVIORAL;


