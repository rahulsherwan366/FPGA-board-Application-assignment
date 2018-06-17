--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : lab4_seven_segment_display.vhf
-- /___/   /\     Timestamp : 09/18/2017 19:24:48
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/unwrapped/sch2hdl -intstyle ise -family artix7 -flat -suppress -vhdl lab4_seven_segment_display.vhf -w /home/kgopal/lab4_seven_segment_display/lab4_seven_segment_display.sch
--Design Name: lab4_seven_segment_display
--Device: artix7
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL OR6_HXILINX_lab4_seven_segment_display -----

--carry propagate

  ---------------------------------------------------------
-- Basic multiplier cell 
-- 
----------------------------------------------------------		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity cell is
    Port ( X_i : in std_logic;
           Y_j : in std_logic;
           Cin : in std_logic; 
           Pin : in std_logic;
           Cout : out std_logic;
           Pout : out std_logic
			  );
end cell;

architecture Behavioral of cell is
signal int_and: std_logic;
begin
  int_and <= X_i and Y_j;	
  Cout <= (Cin and Pin) or (Cin and int_and) or (Pin and int_and);
  Pout <= Cin xor int_and xor Pin;
end Behavioral;

		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity multiplier1 is
    Port ( X : in std_logic_vector(8-1 downto 0);
           Y : in std_logic_vector(8-1 downto 0);
           P : out std_logic_vector(8+8-1 downto 0));
end multiplier1;

architecture Behavioral of multiplier1 is

component cell
    Port ( X_i : in std_logic;
           Y_j : in std_logic;
           Cin : in std_logic; 
           Pin : in std_logic;
           Cout : out std_logic;
           Pout : out std_logic
			  );
end component;
type conections is array (0 to 8) of STD_LOGIC_VECTOR (8 downto 0);
Signal Cin, Pin, Cout, Pout: conections;
begin

init: for i in 0 to 8-1 generate Cin(i)(0) <= '0'; end generate;
Pin(0) <= (others => '0');

ext_loop: for i in 0 to 8-1 generate
  int_loop: for j in 0 to 8-1 generate
	 cell1: cell port map( X_i => X(i), Y_j => Y(j),
		           Cin => Cin(i)(j), Pin => Pin(i)(j),
		           Cout => Cout(i)(j),  Pout => Pout(i)(j) );
				Cin(i)(j+1) <= Cout(i)(j);
				j_0: if J = 0 generate P(i) <= Pout(i)(j); end generate;
				jn0: if J > 0 generate Pin(i+1)(j-1) <= Pout(i)(j); end generate;
	 end generate;
	 Pin(i+1)(8-1) <= Cin(i)(8);
end generate;

P(8+8-1 downto 8) <= Pin(8)(8-1 downto 0);

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity HALFADDER is
  port(A,   B:     in  std_logic;
       SUM, CARRY: out std_logic);
end HALFADDER;

architecture DATAFLOW of HALFADDER is
begin
    SUM   <= A xor B;
    CARRY <= A and B;
end DATAFLOW;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity fullADDER is
  port(A, B, CIN: in  std_logic;
       SUM, COUT: out std_logic);
end fullADDER;

architecture STRUCT of fullADDER is
component HALFADDER
  port(A,   B:     in  std_logic;
       SUM, CARRY: out std_logic);
end component;
signal U0_CARRY, U0_SUM, U1_CARRY: std_logic;

begin
  U0: HALFADDER port map (A => A,      B => B,   SUM => U0_SUM, CARRY => U0_CARRY);
  U1: HALFADDER port map (A => U0_SUM, B => CIN, SUM => SUM,    CARRY => U1_CARRY);

  COUT <= U0_CARRY or U1_CARRY;
end STRUCT;





library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;


ENTITY ripple_adder IS
 Generic (n: integer:=7);
    PORT
        (
         x_in      :  IN   STD_LOGIC_VECTOR(n-1 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(n-1 DOWNTO 0);
         sum       :  OUT  STD_LOGIC_VECTOR(n DOWNTO 0)
        );
END ripple_adder;

ARCHITECTURE behavioral OF ripple_adder IS
SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(n DOWNTO 0);
SIGNAL    carry_in  :   STD_LOGIC :=('0');

component fullADDER
  port( A, B, CIN : in  std_logic ;
       SUM, COUT : out std_logic );
end component;

BEGIN

    carry_in_internal(0)<=carry_in ;
 
        inst: FOR i IN 0 TO n-1 generate
    gen  :   fulladder port map (a=>x_in(i),b=>y_in(i),cin=>carry_in_internal(i),sum=>sum(i),cout=>carry_in_internal(i+1));
              END generate;
    sum(n)<=  carry_in_internal(n);

    END behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity multiplier2 is
    Generic (N: integer:=8);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Y : in  STD_LOGIC_VECTOR (N-1 downto 0); 
           P : out  STD_LOGIC_VECTOR (2*N-1 downto 0)); 
end multiplier2;

architecture structural of multiplier2 is
 
  type product_terms is array (0 to N-1) of std_logic_vector(0 to N-1);
  signal XY: product_terms;

 
  type interconnect is array (0 to N-2) of std_logic_vector(N-2 downto 0);
  signal C, S: interconnect;
  

  signal addend, partial_prod: std_logic_vector(N-2 downto 0);
 
  component HalfAdder is
    Port ( A, B : in  STD_LOGIC;
            Sum , Carry : out  STD_LOGIC);
  end component;
  
 
  component FullAdder is
    Port ( A, B, Cin : in  STD_LOGIC;
          Sum , Cout : out  STD_LOGIC);
  end component;
 
  component ripple_adder is
    Port ( X_in, Y_in: in  STD_LOGIC_VECTOR (6 downto 0);
           Sum : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;

begin

   
	process (X, Y)
	begin
	  for i in 0 to N-1 loop
	    for j in 0 to N-1 loop
		   XY(j)(i) <= X(j) and Y(i);
		 end loop;
	  end loop;
	end process;

   
   Gen1: for j in 0 to N-2 generate
   
     HA1: HalfAdder port map(a=>XY(j+1)(0),b=>XY(j)(1),carry=>C(0)(j),sum=>S(0)(j));
	  Gen2: for i in 1 to N-2 generate  
	    GenMSB: if j=N-2 generate 
		   FA1: FullAdder port map(a=>XY(j)(i+1),b=>XY(j+1)(i),cin=>C(i-1)(j),cout=>C(i)(j),sum=>S(i)(j));
		 end generate;
	    GenNorm: if j<N-2 generate 
		   FA2: FullAdder port map(a=>XY(j)(i+1),b=>S(i-1)(j+1),cin=>C(i-1)(j),cout=>C(i)(j),sum=>S(i)(j));
		 end generate;
	  end generate;
	end generate;
	
	
	process (S)
	begin
	  for i in 0 to N-2 loop
		 partial_prod(i) <= S(i)(0);
	  end loop;
	end process;

	P(N-1 downto 0)<= partial_prod & XY(0)(0);
	
	addend <= XY(N-1)(N-1) & S(N-2)(N-2 downto 1);
	FCA1: ripple_adder  port map(x_in=>C(N-2),y_in=>addend,sum=>P(2*N-1 downto N));
	
end structural;


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fastadder IS
 Generic (n: integer:=7);
    PORT
        (
         x_in      :  IN   STD_LOGIC_VECTOR(n-1 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(n-1 DOWNTO 0);
         sum       :  OUT  STD_LOGIC_VECTOR(n DOWNTO 0)
        );
END fastadder;

ARCHITECTURE behavioral OF fastadder IS

SIGNAL    h_sum              :    STD_LOGIC_VECTOR(n-1 DOWNTO 0);
SIGNAL    carry_generate     :    STD_LOGIC_VECTOR(n-1 DOWNTO 0);
SIGNAL    carry_propagate    :    STD_LOGIC_VECTOR(n-1 DOWNTO 0);
SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(n DOWNTO 1);
SIGNAL    carry_in  :   STD_LOGIC :=('0');
BEGIN
    h_sum <= x_in XOR y_in;
    carry_generate <= x_in AND y_in;
    carry_propagate <= x_in OR y_in;
    PROCESS (carry_generate,carry_propagate,carry_in_internal)
    BEGIN
    carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND carry_in);
        inst: FOR i IN 1 TO n-1 LOOP
              carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));
              END LOOP;
    sum(n)<= carry_in_internal(n);
    END PROCESS;

    sum(0) <= h_sum(0) XOR carry_in;
    sum(n-1 DOWNTO 1) <= h_sum(n-1 DOWNTO 1) XOR carry_in_internal(n-1 DOWNTO 1);
END behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;
 



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.VComponents.all;


entity multiplier3 is
    Generic (N: integer:=8);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0); 
           Y : in  STD_LOGIC_VECTOR (N-1 downto 0); 
           P : out  STD_LOGIC_VECTOR (2*N-1 downto 0)); 
end multiplier3;

architecture structural of multiplier3 is
 
  
  type product_terms is array (0 to N-1) of std_logic_vector(0 to N-1);
  signal XY: product_terms;

 
  type interconnect is array (0 to N-2) of std_logic_vector(N-2 downto 0);
  signal C, S: interconnect;
  
  
  signal addend, partial_prod: std_logic_vector(N-2 downto 0);
 

  component HalfAdder is
    Port ( A, B : in  STD_LOGIC;
            Sum , Carry : out  STD_LOGIC);
  end component;
  
  component FullAdder is
    Port ( A, B, Cin : in  STD_LOGIC;
          Sum , Cout : out  STD_LOGIC);
  end component;
  
 
  component FastAdder is
    Port ( X_in, Y_in: in  STD_LOGIC_VECTOR (6 downto 0);
           Sum : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;

begin

  
	process (X, Y)
	begin
	  for i in 0 to N-1 loop
	    for j in 0 to N-1 loop
		   XY(j)(i) <= X(j) and Y(i);
		 end loop;
	  end loop;
	end process;

   
   Gen1: for j in 0 to N-2 generate
   
     HA1: HalfAdder port map(a=>XY(j+1)(0),b=>XY(j)(1),carry=>C(0)(j),sum=>S(0)(j));
	  Gen2: for i in 1 to N-2 generate 
	    GenMSB: if j=N-2 generate 
		   FA1: FullAdder port map(a=>XY(j)(i+1),b=>XY(j+1)(i),cin=>C(i-1)(j),cout=>C(i)(j),sum=>S(i)(j));
		 end generate;
	    GenNorm: if j<N-2 generate 
		   FA2: FullAdder port map(a=>XY(j)(i+1),b=>S(i-1)(j+1),cin=>C(i-1)(j),cout=>C(i)(j),sum=>S(i)(j));
		 end generate;
	  end generate;
	end generate;
	
	process (S)
	begin
	  for i in 0 to N-2 loop
		 partial_prod(i) <= S(i)(0);
	  end loop;
	end process;

	P(N-1 downto 0)<= partial_prod & XY(0)(0);
	

	addend <= XY(N-1)(N-1) & S(N-2)(N-2 downto 1);
	FCA1: FastAdder  port map(x_in=>C(N-2),y_in=>addend,sum=>P(2*N-1 downto N));
	
end structural;


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OR6_HXILINX_lab4_seven_segment_display is
  
port(
    O  : out std_logic;

    I0  : in std_logic;
    I1  : in std_logic;
    I2  : in std_logic;
    I3  : in std_logic;
    I4  : in std_logic;
    I5  : in std_logic
  );
end OR6_HXILINX_lab4_seven_segment_display;

architecture OR6_HXILINX_lab4_seven_segment_display_V of OR6_HXILINX_lab4_seven_segment_display is
begin
  O <=  (I0 or I1 or I2 or I3 or I4 or I5);
end OR6_HXILINX_lab4_seven_segment_display_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity slowclockmahla_MUSER_lab4_seven_segment_display is
   port ( clock     : in    std_logic; 
          slowclock : out   std_logic);
end slowclockmahla_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of slowclockmahla_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_25         : std_logic;
   signal XLXN_26         : std_logic;
   signal XLXN_28         : std_logic;
   signal XLXN_29         : std_logic;
   signal XLXN_30         : std_logic;
   signal XLXN_31         : std_logic;
   signal XLXN_33         : std_logic;
   signal XLXN_34         : std_logic;
   signal XLXN_36         : std_logic;
   signal XLXN_39         : std_logic;
   signal XLXN_40         : std_logic;
   signal XLXN_42         : std_logic;
   signal XLXN_43         : std_logic;
   signal XLXN_45         : std_logic;
   signal XLXN_46         : std_logic;
   signal XLXN_48         : std_logic;
   signal XLXN_49         : std_logic;
   signal XLXN_50         : std_logic;
   signal XLXN_51         : std_logic;
   signal XLXN_52         : std_logic;
   signal XLXN_53         : std_logic;
   signal XLXN_55         : std_logic;
   signal XLXN_56         : std_logic;
   signal XLXN_57         : std_logic;
   signal XLXN_58         : std_logic;
   signal XLXN_60         : std_logic;
   signal XLXN_61         : std_logic;
   signal XLXN_63         : std_logic;
   signal XLXN_64         : std_logic;
   signal XLXN_65         : std_logic;
   signal XLXN_66         : std_logic;
   signal XLXN_69         : std_logic;
   signal XLXN_72         : std_logic;
   signal slowclock_DUMMY : std_logic;
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   slowclock <= slowclock_DUMMY;
   XLXI_1 : FD
      port map (C=>clock,
                D=>XLXN_26,
                Q=>XLXN_25);
   
   XLXI_42 : FD
      port map (C=>XLXN_25,
                D=>XLXN_29,
                Q=>XLXN_28);
   
   XLXI_43 : FD
      port map (C=>XLXN_28,
                D=>XLXN_31,
                Q=>XLXN_30);
   
   XLXI_44 : FD
      port map (C=>XLXN_30,
                D=>XLXN_34,
                Q=>XLXN_33);
   
   XLXI_45 : FD
      port map (C=>XLXN_33,
                D=>XLXN_36,
                Q=>XLXN_72);
   
   XLXI_46 : FD
      port map (C=>XLXN_72,
                D=>XLXN_40,
                Q=>XLXN_39);
   
   XLXI_47 : FD
      port map (C=>XLXN_39,
                D=>XLXN_43,
                Q=>XLXN_42);
   
   XLXI_48 : FD
      port map (C=>XLXN_42,
                D=>XLXN_46,
                Q=>XLXN_45);
   
   XLXI_49 : FD
      port map (C=>XLXN_45,
                D=>XLXN_49,
                Q=>XLXN_48);
   
   XLXI_50 : FD
      port map (C=>XLXN_48,
                D=>XLXN_51,
                Q=>XLXN_50);
   
   XLXI_51 : FD
      port map (C=>XLXN_50,
                D=>XLXN_53,
                Q=>XLXN_52);
   
   XLXI_52 : FD
      port map (C=>XLXN_52,
                D=>XLXN_56,
                Q=>XLXN_55);
   
   XLXI_53 : FD
      port map (C=>XLXN_55,
                D=>XLXN_58,
                Q=>XLXN_57);
   
   XLXI_54 : FD
      port map (C=>XLXN_57,
                D=>XLXN_61,
                Q=>XLXN_60);
   
   XLXI_55 : FD
      port map (C=>XLXN_60,
                D=>XLXN_64,
                Q=>XLXN_63);
   
   XLXI_56 : FD
      port map (C=>XLXN_63,
                D=>XLXN_66,
                Q=>XLXN_65);
   
   XLXI_57 : FD
      port map (C=>XLXN_65,
                D=>XLXN_69,
                Q=>slowclock_DUMMY);
   
   XLXI_58 : INV
      port map (I=>XLXN_25,
                O=>XLXN_26);
   
   XLXI_59 : INV
      port map (I=>XLXN_28,
                O=>XLXN_29);
   
   XLXI_60 : INV
      port map (I=>XLXN_30,
                O=>XLXN_31);
   
   XLXI_61 : INV
      port map (I=>XLXN_33,
                O=>XLXN_34);
   
   XLXI_62 : INV
      port map (I=>XLXN_72,
                O=>XLXN_36);
   
   XLXI_63 : INV
      port map (I=>XLXN_39,
                O=>XLXN_40);
   
   XLXI_64 : INV
      port map (I=>XLXN_42,
                O=>XLXN_43);
   
   XLXI_65 : INV
      port map (I=>XLXN_45,
                O=>XLXN_46);
   
   XLXI_66 : INV
      port map (I=>XLXN_48,
                O=>XLXN_49);
   
   XLXI_67 : INV
      port map (I=>XLXN_50,
                O=>XLXN_51);
   
   XLXI_68 : INV
      port map (I=>XLXN_52,
                O=>XLXN_53);
   
   XLXI_69 : INV
      port map (I=>XLXN_55,
                O=>XLXN_56);
   
   XLXI_70 : INV
      port map (I=>XLXN_57,
                O=>XLXN_58);
   
   XLXI_71 : INV
      port map (I=>XLXN_60,
                O=>XLXN_61);
   
   XLXI_72 : INV
      port map (I=>XLXN_63,
                O=>XLXN_64);
   
   XLXI_73 : INV
      port map (I=>XLXN_65,
                O=>XLXN_66);
   
   XLXI_74 : INV
      port map (I=>slowclock_DUMMY,
                O=>XLXN_69);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity vashisht_MUSER_lab4_seven_segment_display is
   port ( clock      : in    std_logic; 
          pushbutton : in    std_logic; 
          finalclock : out   std_logic);
end vashisht_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of vashisht_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_3     : std_logic;
   component MUXCY
      port ( CI : in    std_logic; 
             DI : in    std_logic; 
             S  : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of MUXCY : component is "BLACK_BOX";
   
   component slowclockmahla_MUSER_lab4_seven_segment_display
      port ( clock     : in    std_logic; 
             slowclock : out   std_logic);
   end component;
   
begin
   XLXI_2 : MUXCY
      port map (CI=>clock,
                DI=>XLXN_3,
                S=>pushbutton,
                O=>finalclock);
   
   XLXI_3 : slowclockmahla_MUSER_lab4_seven_segment_display
      port map (clock=>clock,
                slowclock=>XLXN_3);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity ringmehlu_MUSER_lab4_seven_segment_display is
   port ( clock : in    std_logic; 
          A     : out   std_logic_vector (3 downto 0));
end ringmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of ringmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_1 : std_logic;
   signal XLXN_2 : std_logic;
   signal XLXN_3 : std_logic;
   signal XLXN_6 : std_logic;
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : FD
   generic map( INIT => '1')
      port map (C=>clock,
                D=>XLXN_6,
                Q=>XLXN_1);
   
   XLXI_3 : FD
      port map (C=>clock,
                D=>XLXN_1,
                Q=>XLXN_2);
   
   XLXI_4 : FD
      port map (C=>clock,
                D=>XLXN_2,
                Q=>XLXN_3);
   
   XLXI_5 : FD
      port map (C=>clock,
                D=>XLXN_3,
                Q=>XLXN_6);
   
   XLXI_6 : INV
      port map (I=>XLXN_1,
                O=>A(0));
   
   XLXI_7 : INV
      port map (I=>XLXN_2,
                O=>A(1));
   
   XLXI_8 : INV
      port map (I=>XLXN_3,
                O=>A(2));
   
   XLXI_10 : INV
      port map (I=>XLXN_6,
                O=>A(3));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity gmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end gmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of gmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4
      port map (I0=>XLXN_12,
                I1=>XLXN_11,
                I2=>XLXN_10,
                I3=>XLXN_9,
                O=>XLXN_3);
   
   XLXI_2 : AND4
      port map (I0=>d(0),
                I1=>XLXN_15,
                I2=>XLXN_14,
                I3=>XLXN_13,
                O=>XLXN_4);
   
   XLXI_3 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>XLXN_16,
                O=>XLXN_5);
   
   XLXI_4 : AND4
      port map (I0=>XLXN_18,
                I1=>XLXN_17,
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_6);
   
   XLXI_5 : OR4
      port map (I0=>XLXN_6,
                I1=>XLXN_5,
                I2=>XLXN_4,
                I3=>XLXN_3,
                O=>q);
   
   XLXI_6 : INV
      port map (I=>d(3),
                O=>XLXN_9);
   
   XLXI_7 : INV
      port map (I=>d(2),
                O=>XLXN_10);
   
   XLXI_8 : INV
      port map (I=>d(1),
                O=>XLXN_11);
   
   XLXI_9 : INV
      port map (I=>d(0),
                O=>XLXN_12);
   
   XLXI_10 : INV
      port map (I=>d(3),
                O=>XLXN_13);
   
   XLXI_11 : INV
      port map (I=>d(2),
                O=>XLXN_14);
   
   XLXI_12 : INV
      port map (I=>d(1),
                O=>XLXN_15);
   
   XLXI_13 : INV
      port map (I=>d(3),
                O=>XLXN_16);
   
   XLXI_14 : INV
      port map (I=>d(1),
                O=>XLXN_17);
   
   XLXI_15 : INV
      port map (I=>d(0),
                O=>XLXN_18);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity fmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end fmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of fmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   signal XLXN_23 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4
      port map (I0=>d(0),
                I1=>XLXN_14,
                I2=>XLXN_13,
                I3=>XLXN_12,
                O=>XLXN_5);
   
   XLXI_2 : AND4
      port map (I0=>XLXN_17,
                I1=>d(1),
                I2=>XLXN_16,
                I3=>XLXN_15,
                O=>XLXN_6);
   
   XLXI_3 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>XLXN_19,
                I3=>XLXN_18,
                O=>XLXN_7);
   
   XLXI_4 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>XLXN_20,
                O=>XLXN_8);
   
   XLXI_5 : AND4
      port map (I0=>d(0),
                I1=>XLXN_23,
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_10);
   
   XLXI_7 : OR5
      port map (I0=>XLXN_10,
                I1=>XLXN_8,
                I2=>XLXN_7,
                I3=>XLXN_6,
                I4=>XLXN_5,
                O=>q);
   
   XLXI_8 : INV
      port map (I=>d(3),
                O=>XLXN_12);
   
   XLXI_9 : INV
      port map (I=>d(2),
                O=>XLXN_13);
   
   XLXI_10 : INV
      port map (I=>d(1),
                O=>XLXN_14);
   
   XLXI_11 : INV
      port map (I=>d(3),
                O=>XLXN_15);
   
   XLXI_12 : INV
      port map (I=>d(2),
                O=>XLXN_16);
   
   XLXI_13 : INV
      port map (I=>d(0),
                O=>XLXN_17);
   
   XLXI_14 : INV
      port map (I=>d(3),
                O=>XLXN_18);
   
   XLXI_15 : INV
      port map (I=>d(2),
                O=>XLXN_19);
   
   XLXI_16 : INV
      port map (I=>d(3),
                O=>XLXN_20);
   
   XLXI_20 : INV
      port map (I=>d(1),
                O=>XLXN_23);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity emehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end emehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of emehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   attribute HU_SET     : string ;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   signal XLXN_21 : std_logic;
   signal XLXN_22 : std_logic;
   signal XLXN_23 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR6_HXILINX_lab4_seven_segment_display
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             I5 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_8 : label is "XLXI_8_0";
begin
   XLXI_2 : AND4
      port map (I0=>d(0),
                I1=>XLXN_13,
                I2=>XLXN_12,
                I3=>XLXN_11,
                O=>XLXN_4);
   
   XLXI_3 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>XLXN_15,
                I3=>XLXN_14,
                O=>XLXN_5);
   
   XLXI_4 : AND4
      port map (I0=>XLXN_18,
                I1=>XLXN_17,
                I2=>d(2),
                I3=>XLXN_16,
                O=>XLXN_6);
   
   XLXI_5 : AND4
      port map (I0=>d(0),
                I1=>XLXN_20,
                I2=>d(2),
                I3=>XLXN_19,
                O=>XLXN_7);
   
   XLXI_6 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>XLXN_21,
                O=>XLXN_8);
   
   XLXI_7 : AND4
      port map (I0=>d(0),
                I1=>XLXN_23,
                I2=>XLXN_22,
                I3=>d(3),
                O=>XLXN_9);
   
   XLXI_8 : OR6_HXILINX_lab4_seven_segment_display
      port map (I0=>XLXN_9,
                I1=>XLXN_8,
                I2=>XLXN_7,
                I3=>XLXN_6,
                I4=>XLXN_5,
                I5=>XLXN_4,
                O=>q);
   
   XLXI_9 : INV
      port map (I=>d(3),
                O=>XLXN_11);
   
   XLXI_10 : INV
      port map (I=>d(2),
                O=>XLXN_12);
   
   XLXI_11 : INV
      port map (I=>d(1),
                O=>XLXN_13);
   
   XLXI_12 : INV
      port map (I=>d(3),
                O=>XLXN_14);
   
   XLXI_13 : INV
      port map (I=>d(2),
                O=>XLXN_15);
   
   XLXI_14 : INV
      port map (I=>d(3),
                O=>XLXN_16);
   
   XLXI_15 : INV
      port map (I=>d(1),
                O=>XLXN_17);
   
   XLXI_16 : INV
      port map (I=>d(0),
                O=>XLXN_18);
   
   XLXI_17 : INV
      port map (I=>d(3),
                O=>XLXN_19);
   
   XLXI_18 : INV
      port map (I=>d(1),
                O=>XLXN_20);
   
   XLXI_19 : INV
      port map (I=>d(3),
                O=>XLXN_21);
   
   XLXI_20 : INV
      port map (I=>d(2),
                O=>XLXN_22);
   
   XLXI_21 : INV
      port map (I=>d(1),
                O=>XLXN_23);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity dmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end dmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of dmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4
      port map (I0=>d(0),
                I1=>XLXN_10,
                I2=>XLXN_9,
                I3=>XLXN_8,
                O=>XLXN_2);
   
   XLXI_2 : AND4
      port map (I0=>XLXN_17,
                I1=>XLXN_12,
                I2=>d(2),
                I3=>XLXN_11,
                O=>XLXN_3);
   
   XLXI_3 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>XLXN_18,
                O=>XLXN_4);
   
   XLXI_4 : AND4
      port map (I0=>XLXN_20,
                I1=>d(1),
                I2=>XLXN_19,
                I3=>d(3),
                O=>XLXN_5);
   
   XLXI_5 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_6);
   
   XLXI_6 : OR5
      port map (I0=>XLXN_6,
                I1=>XLXN_5,
                I2=>XLXN_4,
                I3=>XLXN_3,
                I4=>XLXN_2,
                O=>q);
   
   XLXI_7 : INV
      port map (I=>d(3),
                O=>XLXN_8);
   
   XLXI_8 : INV
      port map (I=>d(2),
                O=>XLXN_9);
   
   XLXI_9 : INV
      port map (I=>d(1),
                O=>XLXN_10);
   
   XLXI_10 : INV
      port map (I=>d(3),
                O=>XLXN_11);
   
   XLXI_12 : INV
      port map (I=>d(1),
                O=>XLXN_12);
   
   XLXI_13 : INV
      port map (I=>d(0),
                O=>XLXN_17);
   
   XLXI_14 : INV
      port map (I=>d(3),
                O=>XLXN_18);
   
   XLXI_15 : INV
      port map (I=>d(2),
                O=>XLXN_19);
   
   XLXI_16 : INV
      port map (I=>d(0),
                O=>XLXN_20);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity cmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end cmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of cmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_1  : std_logic;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4
      port map (I0=>XLXN_3,
                I1=>d(1),
                I2=>XLXN_2,
                I3=>XLXN_1,
                O=>XLXN_9);
   
   XLXI_2 : AND4
      port map (I0=>XLXN_5,
                I1=>XLXN_4,
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_10);
   
   XLXI_3 : AND4
      port map (I0=>XLXN_6,
                I1=>d(1),
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_11);
   
   XLXI_4 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_12);
   
   XLXI_6 : OR4
      port map (I0=>XLXN_12,
                I1=>XLXN_11,
                I2=>XLXN_10,
                I3=>XLXN_9,
                O=>q);
   
   XLXI_7 : INV
      port map (I=>d(3),
                O=>XLXN_1);
   
   XLXI_8 : INV
      port map (I=>d(2),
                O=>XLXN_2);
   
   XLXI_9 : INV
      port map (I=>d(0),
                O=>XLXN_3);
   
   XLXI_10 : INV
      port map (I=>d(1),
                O=>XLXN_4);
   
   XLXI_11 : INV
      port map (I=>d(0),
                O=>XLXN_5);
   
   XLXI_12 : INV
      port map (I=>d(0),
                O=>XLXN_6);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity bmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end bmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of bmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   attribute HU_SET     : string ;
   signal XLXN_34 : std_logic;
   signal XLXN_35 : std_logic;
   signal XLXN_36 : std_logic;
   signal XLXN_37 : std_logic;
   signal XLXN_38 : std_logic;
   signal XLXN_39 : std_logic;
   signal XLXN_40 : std_logic;
   signal XLXN_41 : std_logic;
   signal XLXN_42 : std_logic;
   signal XLXN_43 : std_logic;
   signal XLXN_44 : std_logic;
   signal XLXN_45 : std_logic;
   signal XLXN_46 : std_logic;
   signal XLXN_47 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR6_HXILINX_lab4_seven_segment_display
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             I5 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_14 : label is "XLXI_14_1";
begin
   XLXI_8 : AND4
      port map (I0=>d(0),
                I1=>XLXN_41,
                I2=>d(2),
                I3=>XLXN_40,
                O=>XLXN_34);
   
   XLXI_9 : AND4
      port map (I0=>XLXN_43,
                I1=>d(1),
                I2=>d(2),
                I3=>XLXN_42,
                O=>XLXN_35);
   
   XLXI_10 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>XLXN_44,
                I3=>d(3),
                O=>XLXN_36);
   
   XLXI_11 : AND4
      port map (I0=>XLXN_45,
                I1=>XLXN_46,
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_37);
   
   XLXI_12 : AND4
      port map (I0=>XLXN_47,
                I1=>d(1),
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_38);
   
   XLXI_13 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_39);
   
   XLXI_14 : OR6_HXILINX_lab4_seven_segment_display
      port map (I0=>XLXN_39,
                I1=>XLXN_38,
                I2=>XLXN_37,
                I3=>XLXN_36,
                I4=>XLXN_35,
                I5=>XLXN_34,
                O=>q);
   
   XLXI_15 : INV
      port map (I=>d(3),
                O=>XLXN_40);
   
   XLXI_16 : INV
      port map (I=>d(1),
                O=>XLXN_41);
   
   XLXI_17 : INV
      port map (I=>d(3),
                O=>XLXN_42);
   
   XLXI_18 : INV
      port map (I=>d(0),
                O=>XLXN_43);
   
   XLXI_19 : INV
      port map (I=>d(2),
                O=>XLXN_44);
   
   XLXI_20 : INV
      port map (I=>d(0),
                O=>XLXN_45);
   
   XLXI_21 : INV
      port map (I=>d(1),
                O=>XLXN_46);
   
   XLXI_22 : INV
      port map (I=>d(0),
                O=>XLXN_47);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity amehlu_MUSER_lab4_seven_segment_display is
   port ( d     : in    std_logic_vector (3 downto 0); 
          mehlu : out   std_logic);
end amehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of amehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_1  : std_logic;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   component AND4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND4 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND4
      port map (I0=>d(0),
                I1=>XLXN_15,
                I2=>XLXN_14,
                I3=>XLXN_13,
                O=>XLXN_1);
   
   XLXI_2 : AND4
      port map (I0=>XLXN_18,
                I1=>XLXN_17,
                I2=>d(2),
                I3=>XLXN_16,
                O=>XLXN_2);
   
   XLXI_3 : AND4
      port map (I0=>d(0),
                I1=>d(1),
                I2=>XLXN_19,
                I3=>d(3),
                O=>XLXN_3);
   
   XLXI_4 : AND4
      port map (I0=>d(0),
                I1=>XLXN_20,
                I2=>d(2),
                I3=>d(3),
                O=>XLXN_4);
   
   XLXI_5 : OR4
      port map (I0=>XLXN_4,
                I1=>XLXN_3,
                I2=>XLXN_2,
                I3=>XLXN_1,
                O=>mehlu);
   
   XLXI_6 : INV
      port map (I=>d(3),
                O=>XLXN_13);
   
   XLXI_7 : INV
      port map (I=>d(2),
                O=>XLXN_14);
   
   XLXI_8 : INV
      port map (I=>d(1),
                O=>XLXN_15);
   
   XLXI_9 : INV
      port map (I=>d(3),
                O=>XLXN_16);
   
   XLXI_14 : INV
      port map (I=>d(1),
                O=>XLXN_17);
   
   XLXI_15 : INV
      port map (I=>d(0),
                O=>XLXN_18);
   
   XLXI_16 : INV
      port map (I=>d(2),
                O=>XLXN_19);
   
   XLXI_17 : INV
      port map (I=>d(1),
                O=>XLXN_20);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity finalmehlu_MUSER_lab4_seven_segment_display is
   port ( d : in    std_logic_vector (3 downto 0); 
          q : out   std_logic_vector (6 downto 0));
end finalmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of finalmehlu_MUSER_lab4_seven_segment_display is
   component amehlu_MUSER_lab4_seven_segment_display
      port ( d     : in    std_logic_vector (3 downto 0); 
             mehlu : out   std_logic);
   end component;
   
   component bmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
   component cmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
   component dmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
   component emehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
   component fmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
   component gmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic);
   end component;
   
begin
   XLXI_19 : amehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                mehlu=>q(0));
   
   XLXI_20 : bmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(1));
   
   XLXI_21 : cmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(2));
   
   XLXI_22 : dmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(3));
   
   XLXI_23 : emehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(4));
   
   XLXI_24 : fmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(5));
   
   XLXI_25 : gmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>d(3 downto 0),
                q=>q(6));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity muxpartmehlu_MUSER_lab4_seven_segment_display is
   port ( v : in    std_logic_vector (3 downto 0); 
          w : in    std_logic_vector (3 downto 0); 
          q : out   std_logic);
end muxpartmehlu_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of muxpartmehlu_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_4  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_40 : std_logic;
   signal XLXN_43 : std_logic;
   signal XLXN_47 : std_logic;
   signal XLXN_48 : std_logic;
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
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>XLXN_4,
                I1=>w(0),
                O=>XLXN_43);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_6,
                I1=>w(1),
                O=>XLXN_47);
   
   XLXI_3 : AND2
      port map (I0=>XLXN_8,
                I1=>w(2),
                O=>XLXN_48);
   
   XLXI_4 : AND2
      port map (I0=>XLXN_10,
                I1=>w(3),
                O=>XLXN_40);
   
   XLXI_18 : INV
      port map (I=>v(0),
                O=>XLXN_4);
   
   XLXI_19 : INV
      port map (I=>v(1),
                O=>XLXN_6);
   
   XLXI_20 : INV
      port map (I=>v(2),
                O=>XLXN_8);
   
   XLXI_21 : INV
      port map (I=>v(3),
                O=>XLXN_10);
   
   XLXI_22 : OR4
      port map (I0=>XLXN_40,
                I1=>XLXN_48,
                I2=>XLXN_47,
                I3=>XLXN_43,
                O=>q);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity byas_MUSER_lab4_seven_segment_display is
   port ( a   : in    std_logic_vector (3 downto 0); 
          b0  : in    std_logic; 
          b1  : in    std_logic; 
          b2  : in    std_logic; 
          b3  : in    std_logic; 
          b4  : in    std_logic; 
          b5  : in    std_logic; 
          b6  : in    std_logic; 
          b7  : in    std_logic; 
          b8  : in    std_logic; 
          b9  : in    std_logic; 
          b10 : in    std_logic; 
          b11 : in    std_logic; 
          b12 : in    std_logic; 
          b13 : in    std_logic; 
          b14 : in    std_logic; 
          b15 : in    std_logic; 
          a1  : out   std_logic_vector (3 downto 0); 
          a2  : out   std_logic_vector (3 downto 0); 
          a3  : out   std_logic_vector (3 downto 0); 
          a4  : out   std_logic_vector (3 downto 0); 
          z   : out   std_logic_vector (3 downto 0));
end byas_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of byas_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_62  : std_logic;
   signal XLXN_63  : std_logic;
   signal XLXN_65  : std_logic;
   signal XLXN_68  : std_logic;
   signal XLXN_69  : std_logic;
   signal XLXN_70  : std_logic;
   signal XLXN_71  : std_logic;
   signal XLXN_73  : std_logic;
   signal XLXN_74  : std_logic;
   signal XLXN_75  : std_logic;
   signal XLXN_76  : std_logic;
   signal XLXN_77  : std_logic;
   signal XLXN_79  : std_logic;
   signal XLXN_80  : std_logic;
   signal XLXN_81  : std_logic;
   signal XLXN_95  : std_logic;
   signal a1_DUMMY : std_logic_vector (3 downto 0);
   signal a2_DUMMY : std_logic_vector (3 downto 0);
   signal a3_DUMMY : std_logic_vector (3 downto 0);
   signal a4_DUMMY : std_logic_vector (3 downto 0);
   component muxpartmehlu_MUSER_lab4_seven_segment_display
      port ( q : out   std_logic; 
             v : in    std_logic_vector (3 downto 0); 
             w : in    std_logic_vector (3 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   a1(3 downto 0) <= a1_DUMMY(3 downto 0);
   a2(3 downto 0) <= a2_DUMMY(3 downto 0);
   a3(3 downto 0) <= a3_DUMMY(3 downto 0);
   a4(3 downto 0) <= a4_DUMMY(3 downto 0);
   XLXI_1 : muxpartmehlu_MUSER_lab4_seven_segment_display
      port map (v(3 downto 0)=>a(3 downto 0),
                w(3 downto 0)=>a1_DUMMY(3 downto 0),
                q=>z(0));
   
   XLXI_2 : muxpartmehlu_MUSER_lab4_seven_segment_display
      port map (v(3 downto 0)=>a(3 downto 0),
                w(3 downto 0)=>a2_DUMMY(3 downto 0),
                q=>z(1));
   
   XLXI_3 : muxpartmehlu_MUSER_lab4_seven_segment_display
      port map (v(3 downto 0)=>a(3 downto 0),
                w(3 downto 0)=>a3_DUMMY(3 downto 0),
                q=>z(2));
   
   XLXI_4 : muxpartmehlu_MUSER_lab4_seven_segment_display
      port map (v(3 downto 0)=>a(3 downto 0),
                w(3 downto 0)=>a4_DUMMY(3 downto 0),
                q=>z(3));
   
   XLXI_6 : INV
      port map (I=>b0,
                O=>XLXN_62);
   
   XLXI_7 : INV
      port map (I=>XLXN_62,
                O=>a1_DUMMY(0));
   
   XLXI_8 : INV
      port map (I=>b2,
                O=>XLXN_63);
   
   XLXI_9 : INV
      port map (I=>XLXN_63,
                O=>a3_DUMMY(0));
   
   XLXI_10 : INV
      port map (I=>b1,
                O=>XLXN_65);
   
   XLXI_11 : INV
      port map (I=>XLXN_65,
                O=>a2_DUMMY(0));
   
   XLXI_12 : INV
      port map (I=>b4,
                O=>XLXN_68);
   
   XLXI_13 : INV
      port map (I=>XLXN_68,
                O=>a1_DUMMY(1));
   
   XLXI_14 : INV
      port map (I=>b6,
                O=>XLXN_69);
   
   XLXI_15 : INV
      port map (I=>XLXN_69,
                O=>a3_DUMMY(1));
   
   XLXI_16 : INV
      port map (I=>b7,
                O=>XLXN_70);
   
   XLXI_17 : INV
      port map (I=>XLXN_70,
                O=>a4_DUMMY(1));
   
   XLXI_18 : INV
      port map (I=>b8,
                O=>XLXN_71);
   
   XLXI_19 : INV
      port map (I=>XLXN_71,
                O=>a1_DUMMY(2));
   
   XLXI_20 : INV
      port map (I=>b3,
                O=>XLXN_73);
   
   XLXI_21 : INV
      port map (I=>XLXN_73,
                O=>a4_DUMMY(0));
   
   XLXI_22 : INV
      port map (I=>b10,
                O=>XLXN_74);
   
   XLXI_23 : INV
      port map (I=>XLXN_74,
                O=>a3_DUMMY(2));
   
   XLXI_24 : INV
      port map (I=>b11,
                O=>XLXN_75);
   
   XLXI_25 : INV
      port map (I=>XLXN_75,
                O=>a4_DUMMY(2));
   
   XLXI_26 : INV
      port map (I=>b5,
                O=>XLXN_76);
   
   XLXI_27 : INV
      port map (I=>XLXN_76,
                O=>a2_DUMMY(1));
   
   XLXI_28 : INV
      port map (I=>b12,
                O=>XLXN_77);
   
   XLXI_29 : INV
      port map (I=>XLXN_77,
                O=>a1_DUMMY(3));
   
   XLXI_32 : INV
      port map (I=>b14,
                O=>XLXN_79);
   
   XLXI_33 : INV
      port map (I=>XLXN_79,
                O=>a3_DUMMY(3));
   
   XLXI_34 : INV
      port map (I=>b15,
                O=>XLXN_80);
   
   XLXI_35 : INV
      port map (I=>XLXN_80,
                O=>a4_DUMMY(3));
   
   XLXI_36 : INV
      port map (I=>b13,
                O=>XLXN_81);
   
   XLXI_37 : INV
      port map (I=>XLXN_81,
                O=>a2_DUMMY(3));
   
   XLXI_40 : INV
      port map (I=>b9,
                O=>XLXN_95);
   
   XLXI_41 : INV
      port map (I=>XLXN_95,
                O=>a2_DUMMY(2));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity lab4_seven_segment_display is
   port ( b          : in    std_logic_vector (15 downto 0); 
          clk        : in    std_logic; 
          pushbutton : in    std_logic; 
          anode      : out   std_logic_vector (3 downto 0); 
          cathode    : out   std_logic_vector (6 downto 0));
end lab4_seven_segment_display;

architecture BEHAVIORAL of lab4_seven_segment_display is
   signal XLXN_41     : std_logic_vector (3 downto 0);
   signal XLXN_44     : std_logic;
   signal anode_DUMMY : std_logic_vector (3 downto 0);
   component byas_MUSER_lab4_seven_segment_display
      port ( a   : in    std_logic_vector (3 downto 0); 
             a1  : out   std_logic_vector (3 downto 0); 
             a2  : out   std_logic_vector (3 downto 0); 
             a3  : out   std_logic_vector (3 downto 0); 
             a4  : out   std_logic_vector (3 downto 0); 
             b0  : in    std_logic; 
             b1  : in    std_logic; 
             b10 : in    std_logic; 
             b11 : in    std_logic; 
             b12 : in    std_logic; 
             b13 : in    std_logic; 
             b14 : in    std_logic; 
             b15 : in    std_logic; 
             b2  : in    std_logic; 
             b3  : in    std_logic; 
             b4  : in    std_logic; 
             b5  : in    std_logic; 
             b6  : in    std_logic; 
             b7  : in    std_logic; 
             b8  : in    std_logic; 
             b9  : in    std_logic; 
             z   : out   std_logic_vector (3 downto 0));
   end component;
   
   component finalmehlu_MUSER_lab4_seven_segment_display
      port ( d : in    std_logic_vector (3 downto 0); 
             q : out   std_logic_vector (6 downto 0));
   end component;
   
   component ringmehlu_MUSER_lab4_seven_segment_display
      port ( A     : out   std_logic_vector (3 downto 0); 
             clock : in    std_logic);
   end component;
   
   component vashisht_MUSER_lab4_seven_segment_display
      port ( clock      : in    std_logic; 
             finalclock : out   std_logic; 
             pushbutton : in    std_logic);
   end component;
   
begin
   anode(3 downto 0) <= anode_DUMMY(3 downto 0);
   XLXI_37 : byas_MUSER_lab4_seven_segment_display
      port map (a(3 downto 0)=>anode_DUMMY(3 downto 0),
                b0=>b(0),
                b1=>b(1),
                b2=>b(2),
                b3=>b(3),
                b4=>b(4),
                b5=>b(5),
                b6=>b(6),
                b7=>b(7),
                b8=>b(8),
                b9=>b(9),
                b10=>b(10),
                b11=>b(11),
                b12=>b(12),
                b13=>b(13),
                b14=>b(14),
                b15=>b(15),
                a1=>open,
                a2=>open,
                a3=>open,
                a4=>open,
                z(3 downto 0)=>XLXN_41(3 downto 0));
   
   XLXI_38 : finalmehlu_MUSER_lab4_seven_segment_display
      port map (d(3 downto 0)=>XLXN_41(3 downto 0),
                q(6 downto 0)=>cathode(6 downto 0));
   
   XLXI_43 : ringmehlu_MUSER_lab4_seven_segment_display
      port map (clock=>XLXN_44,
                A(3 downto 0)=>anode_DUMMY(3 downto 0));
   
   XLXI_44 : vashisht_MUSER_lab4_seven_segment_display
      port map (clock=>clk,
                pushbutton=>pushbutton,
                finalclock=>XLXN_44);
   
end BEHAVIORAL;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity lab6_multiplier is
port(
clk : in std_logic;
in1 : in std_logic_vector(7 downto 0);
in2 : in std_logic_vector(7 downto 0);
display_button : in std_logic;
multiplier_select : in std_logic_vector(1 downto 0);
anode : out std_logic_vector(3 downto 0);
cathode : out std_logic_vector(6 downto 0);
product : out std_logic_vector(15 downto 0));
end lab6_multiplier;
architecture BEH of lab6_multiplier is
signal duct1 :  std_logic_vector(15 downto 0);
signal duct2 :  std_logic_vector(15 downto 0);
signal duct3 :  std_logic_vector(15 downto 0);
signal pro :  std_logic_vector(15 downto 0);
component lab4_seven_segment_display 
   port ( b          : in    std_logic_vector (15 downto 0); 
          clk        : in    std_logic; 
          pushbutton : in    std_logic; 
          anode      : out   std_logic_vector (3 downto 0); 
          cathode    : out   std_logic_vector (6 downto 0));
end component;

component multiplier1 
    Port ( X : in std_logic_vector(8-1 downto 0);
           Y : in std_logic_vector(8-1 downto 0);
           P : out std_logic_vector(8+8-1 downto 0));
end component;

component multiplier2 
    Port ( X : in std_logic_vector(8-1 downto 0);
           Y : in std_logic_vector(8-1 downto 0);
           P : out std_logic_vector(8+8-1 downto 0));
end component;


component multiplier3 
    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0); 
           Y : in  STD_LOGIC_VECTOR (7 downto 0); 
           P : out  STD_LOGIC_VECTOR (15 downto 0)); 
end component;



begin
 XLXI_1 :multiplier1 
     port map (x=>in1,y=>in2,p=>duct1);
               
 XLXI_2 :multiplier2 
      port map (x=>in1,y=>in2,P=>duct2);
  
  
XLXI_3 : multiplier3
    port map (x=>in1,y=>in2,p=>duct3);

   with multiplier_select select
   pro<=duct1 when "00",
        duct2 when "01",
        duct3 when others;
product<=pro;

XLXI_4 : lab4_seven_segment_display 
    port map (b=>pro,anode=>anode,cathode=>cathode,pushbutton=>display_button,clk=>clk
        ); 
        
  end BEH;
        
        
