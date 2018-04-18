   --------------------------------------------------------------------------------
   -- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
   --------------------------------------------------------------------------------
   --   ____  ____ 
   --  /   /\/   / 
   -- /___/  \  /    Vendor: Xilinx 
   -- \   \   \/     Version : 14.7
   --  \   \         Application : sch2hdl
   --  /   /         Filename : rahul.vhf
   -- /___/   /\     Timestamp : 08/22/2017 02:51:26
   -- \   \  /  \ 
   --  \___\/\___\ 
   --
   --Command: sch2hdl -intstyle ise -family artix7 -flat -suppress -vhdl /home/kgopal/rahul/rahul.vhf -w /home/kgopal/rahul/rahul.sch
   --Design Name: rahul
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
   
   entity decoder_MUSER_rahul is
      port ( s0 : in    std_logic; 
             s1 : in    std_logic; 
             y0 : out   std_logic; 
             y1 : out   std_logic; 
             y2 : out   std_logic);
   end decoder_MUSER_rahul;
   
   architecture BEHAVIORAL of decoder_MUSER_rahul is
      attribute BOX_TYPE   : string ;
     signal XLXN_7  : std_logic;
      signal XLXN_8  : std_logic;
      signal XLXN_9  : std_logic;
     signal XLXN_10 : std_logic;
     component AND2
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
      
      component INV
         port ( I : in    std_logic; 
                O : out   std_logic);
      end component;
      attribute BOX_TYPE of INV : component is "BLACK_BOX";
      
   begin
      XLXI_1 : AND2
         port map (I0=>XLXN_8,
                   I1=>XLXN_7,
                   O=>y0);
      
      XLXI_2 : AND2
         port map (I0=>XLXN_9,
                   I1=>s0,
                   O=>y1);
      
      XLXI_3 : AND2
         port map (I0=>s1,
                   I1=>XLXN_10,
                   O=>y2);
      
      XLXI_4 : INV
         port map (I=>s0,
                   O=>XLXN_7);
      
      XLXI_5 : INV
         port map (I=>s1,
                   O=>XLXN_8);
      
      XLXI_6 : INV
         port map (I=>s1,
                   O=>XLXN_9);
      
      XLXI_7 : INV
         port map (I=>s0,
                   O=>XLXN_10);
      
   end BEHAVIORAL;
   
  
  
   library ieee;
   use ieee.std_logic_1164.ALL;
   use ieee.numeric_std.ALL;
   library UNISIM;
   use UNISIM.Vcomponents.ALL;
   
   entity multiplexer_MUSER_rahul is
      port ( e  : in    std_logic; 
             s0 : in    std_logic; 
             s1 : in    std_logic; 
             x0 : in    std_logic; 
             x1 : in    std_logic; 
             x2 : in    std_logic; 
             y  : out   std_logic);
   end multiplexer_MUSER_rahul;
   
  architecture BEHAVIORAL of multiplexer_MUSER_rahul is
      attribute BOX_TYPE   : string ;
      signal XLXN_8  : std_logic;
      signal XLXN_9  : std_logic;
      signal XLXN_10 : std_logic;
      signal XLXN_11 : std_logic;
      signal XLXN_15 : std_logic;
      signal XLXN_16 : std_logic;
      signal XLXN_17 : std_logic;
      signal XLXN_19 : std_logic;
      component AND3
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
               I2 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
      
      component OR3
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                I2 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
      
      component AND2
        port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
      
      component INV
         port ( I : in    std_logic; 
                O : out   std_logic);
      end component;
      attribute BOX_TYPE of INV : component is "BLACK_BOX";
      
   begin
      XLXI_1 : AND3
         port map (I0=>x0,
                  I1=>XLXN_8,
                   I2=>XLXN_9,
                   O=>XLXN_15);
      
     XLXI_2 : AND3
         port map (I0=>x1,
                   I1=>s0,
                   I2=>XLXN_10,
                   O=>XLXN_16);
      
      XLXI_3 : AND3
        port map (I0=>x2,
                   I1=>XLXN_11,
                   I2=>s1,
                   O=>XLXN_17);
      
      XLXI_4 : OR3
        port map (I0=>XLXN_17,
                   I1=>XLXN_16,
                   I2=>XLXN_15,
                   O=>XLXN_19);
      
      XLXI_5 : AND2
         port map (I0=>e,
                   I1=>XLXN_19,
                   O=>y);
     
      XLXI_6 : INV
        port map (I=>s0,
                   O=>XLXN_8);
      
      XLXI_7 : INV
         port map (I=>s1,
                   O=>XLXN_9);
      
      XLXI_8 : INV
         port map (I=>s1,
                   O=>XLXN_10);
     
      XLXI_9 : INV
         port map (I=>s0,
                   O=>XLXN_11);
      
   end BEHAVIORAL;
   
   
   
   library ieee;
   use ieee.std_logic_1164.ALL;
   use ieee.numeric_std.ALL;
   library UNISIM;
   use UNISIM.Vcomponents.ALL;
   
   entity prior_MUSER_rahul is
      port ( x0 : in    std_logic; 
             x1 : in    std_logic; 
             x2 : in    std_logic; 
             e  : out   std_logic; 
             s0 : out   std_logic; 
             s1 : out   std_logic);
   end prior_MUSER_rahul;
  
   architecture BEHAVIORAL of prior_MUSER_rahul is
      attribute BOX_TYPE   : string ;
      signal XLXN_6  : std_logic;
      signal XLXN_11 : std_logic;
     component OR3
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                I2 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
      
     component AND2
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                O  : out   std_logic);
      end component;
      attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
      
      component INV
         port ( I : in    std_logic; 
               O : out   std_logic);
      end component;
      attribute BOX_TYPE of INV : component is "BLACK_BOX";
      
   begin
      XLXI_1 : OR3
         port map (I0=>x2,
                  I1=>x1,
                   I2=>x0,
                   O=>e);
     
      XLXI_2 : AND2
         port map (I0=>x1,
                   I1=>XLXN_6,
                   O=>s0);
      
      XLXI_3 : INV
        port map (I=>x2,
                   O=>XLXN_6);
      
      XLXI_5 : INV
         port map (I=>XLXN_11,
                   O=>s1);
      
     XLXI_6 : INV
         port map (I=>x2,
                   O=>XLXN_11);
      
   end BEHAVIORAL;
   
   
   
   library ieee;
   use ieee.std_logic_1164.ALL;
   use ieee.numeric_std.ALL;
   library UNISIM;
   use UNISIM.Vcomponents.ALL;
    entity rahul is
      port ( dest0 : in    std_logic_vector (1 downto 0); 
             dest1 : in    std_logic_vector (1 downto 0); 
             dest2 : in    std_logic_vector (1 downto 0); 
             din0  : in    std_logic; 
             din1  : in    std_logic; 
             din2  : in    std_logic; 
             req0  : in    std_logic; 
             req1  : in    std_logic; 
             req2  : in    std_logic; 
             ack0  : out   std_logic; 
             ack1  : out   std_logic; 
             ack2  : out   std_logic; 
             dout0 : out   std_logic; 
             dout1 : out   std_logic; 
             dout2 : out   std_logic; 
             src   : out   std_logic_vector (1 downto 0));
   end rahul;
   
  architecture BEHAVIORAL of rahul is
      attribute BOX_TYPE   : string ;
      signal XLXN_20   : std_logic;
      signal XLXN_21   : std_logic;
      signal XLXN_22   : std_logic;
      signal XLXN_23   : std_logic;
      signal XLXN_48   : std_logic;
      signal XLXN_49   : std_logic;
      signal XLXN_50   : std_logic;
      signal XLXN_51   : std_logic;
      signal XLXN_52   : std_logic;
      signal XLXN_53   : std_logic;
      signal XLXN_65   : std_logic;
      signal XLXN_67   : std_logic;
      signal src_DUMMY : std_logic_vector (1 downto 0);
      component prior_MUSER_rahul
         port ( e  : out   std_logic; 
                s0 : out   std_logic; 
                s1 : out   std_logic; 
                x0 : in    std_logic; 
                x1 : in    std_logic; 
               x2 : in    std_logic);
      end component;
      
      component decoder_MUSER_rahul
         port ( s0 : in    std_logic; 
                s1 : in    std_logic; 
                y0 : out   std_logic; 
                y1 : out   std_logic; 
               y2 : out   std_logic);
      end component;
      
      component multiplexer_MUSER_rahul
         port ( e  : in    std_logic; 
                s0 : in    std_logic; 
                s1 : in    std_logic; 
                x0 : in    std_logic; 
                x1 : in    std_logic; 
             x2 : in    std_logic; 
                y  : out   std_logic);
      end component;
      
      component AND2
         port ( I0 : in    std_logic; 
                I1 : in    std_logic; 
                O  : out   std_logic);
      end component;
     attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
      
      component INV
        port ( I : in    std_logic; 
                O : out   std_logic);
      end component;
     attribute BOX_TYPE of INV : component is "BLACK_BOX";
      
   begin
      src(1 downto 0) <= src_DUMMY(1 downto 0);
      XLXI_7 : prior_MUSER_rahul
         port map (x0=>req0,
                   x1=>req1,
                 x2=>req2,
                   e=>XLXN_23,
                   s0=>XLXN_65,
                   s1=>src_DUMMY(1));
      
      XLXI_8 : decoder_MUSER_rahul
         port map (s0=>XLXN_65,
                   s1=>src_DUMMY(1),
                   y0=>XLXN_20,
                   y1=>XLXN_21,
                   y2=>XLXN_22);
      
      XLXI_9 : multiplexer_MUSER_rahul
         port map (e=>XLXN_23,
                   s0=>XLXN_65,
                   s1=>src_DUMMY(1),
                   x0=>din0,
                   x1=>din1,
                   x2=>din2,
                   y=>XLXN_53);
      
      XLXI_10 : multiplexer_MUSER_rahul
         port map (e=>XLXN_23,
                   s0=>XLXN_65,
                   s1=>src_DUMMY(1),
                  x0=>dest0(1),
                   x1=>dest1(1),
                  x2=>dest2(1),
                   y=>XLXN_49);
     
     XLXI_11 : multiplexer_MUSER_rahul
         port map (e=>XLXN_23,
                   s0=>XLXN_65,
                   s1=>src_DUMMY(1),
                   x0=>dest0(0),
                   x1=>dest1(0),
                   x2=>dest2(0),
                   y=>XLXN_48);
      
      XLXI_12 : decoder_MUSER_rahul
         port map (s0=>XLXN_48,
                   s1=>XLXN_49,
                   y0=>XLXN_50,
                   y1=>XLXN_51,
                   y2=>XLXN_52);
      
      XLXI_13 : AND2
         port map (I0=>XLXN_23,
                   I1=>XLXN_20,
                   O=>ack0);
      
      XLXI_14 : AND2
         port map (I0=>XLXN_23,
                   I1=>XLXN_21,
                   O=>ack1);
      
      XLXI_15 : AND2
         port map (I0=>XLXN_23,
                   I1=>XLXN_22,
                   O=>ack2);
      
     XLXI_16 : AND2
         port map (I0=>XLXN_53,
                   I1=>XLXN_50,
                   O=>dout0);
      
      XLXI_17 : AND2
        port map (I0=>XLXN_53,
                   I1=>XLXN_51,
                   O=>dout1);
      
      XLXI_18 : AND2
         port map (I0=>XLXN_53,
                   I1=>XLXN_52,
                   O=>dout2);
     
      XLXI_19 : INV
         port map (I=>XLXN_65,
                   O=>XLXN_67);
      
      XLXI_20 : INV
         port map (I=>XLXN_67,
                   O=>src_DUMMY(0));
      
   end BEHAVIORAL;
