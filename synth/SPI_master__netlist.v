/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06
// Date      : Wed Nov 25 14:11:40 2026
/////////////////////////////////////////////////////////////


module SPI_master ( p_clk, PRESETn, PADDR, PWRITE, PENABLE, PSEL, PWDATA, MISO, 
        SS, PRDATA, s_clk, MOSI, SPI_intrrupt_req, PREADY, PSLVERR );
  input [2:0] PADDR;
  input [7:0] PWDATA;
  output [7:0] PRDATA;
  input p_clk, PRESETn, PWRITE, PENABLE, PSEL, MISO;
  output SS, s_clk, MOSI, SPI_intrrupt_req, PREADY, PSLVERR;
  wire   cpol, cphase, SPISWAI, MISO_receive_pos, MISO_receive_neg,
         MOSI_send_pos, MOSI_send_neg, send_data, mstr, receive_data, lsbfe,
         \UNIT1/N148 , \UNIT1/N147 , \UNIT1/N114 , \UNIT1/N113 , \UNIT1/N80 ,
         \UNIT1/N79 , \UNIT1/N78 , \UNIT1/N77 , \UNIT1/N76 , \UNIT1/N75 ,
         \UNIT1/N74 , \UNIT1/N73 , \UNIT1/N72 , \UNIT1/N71 , \UNIT1/N70 ,
         \UNIT1/N69 , \UNIT1/N68 , \UNIT2/N114 , \UNIT2/RD , \UNIT2/N87 ,
         \UNIT2/N86 , \UNIT2/N85 , \UNIT2/N84 , \UNIT2/N83 , \UNIT2/N82 ,
         \UNIT2/N81 , \UNIT2/N80 , \UNIT2/N79 , \UNIT2/N78 , \UNIT2/N77 ,
         \UNIT2/N76 , \UNIT2/N75 , \UNIT2/N74 , \UNIT2/N73 , \UNIT4/N209 ,
         \UNIT4/N156 , \UNIT4/N124 , \UNIT4/N118 , \UNIT4/N117 , \UNIT4/N116 ,
         \UNIT4/N115 , \UNIT4/N114 , \UNIT4/N113 , \UNIT4/N112 , \UNIT4/N111 ,
         \UNIT4/CR2_0 , \UNIT4/CR1[6] , \UNIT4/SPI_NS[1] , \UNIT4/APB_NS[1] ,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378,
         n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434,
         n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445,
         n446, n447, n448, n449, n450, n451, n452, n453, n454, n455, n456,
         n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, n467,
         n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478,
         n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489,
         n490, n491, n492, n493, n494, n495, n496, n497, n498, n499, n500,
         n501, n502, n503, n504, n505, n506, n507, n508, n509, n510, n511,
         n512, n513, n514, n515, n516, n517, n518, n519, n520, n521, n522,
         n523, n524, n525, n526, n527, n528, n529, n530, n531, n532, n533,
         n534, n535, n536, n537, n538, n539, n540, n541, n542, n543, n544,
         n545, n546, n547, n548, n549, n550, n551, n552, n553, n554, n555,
         n556, n557, n558, n559, n560, n561, n562, n563, n564, n565, n566,
         n567, n568, n569, n570, n571, n572, n573, n574, n575, n576, n577,
         n578, n579, n580, n581, n582, n583, n584, n585, n586, n587, n588,
         n589, n590, n591, n592, n593, n594, n595, n596, n597, n598, n599,
         n600, n601, n602, n603, n604, n605, n606, n607, n608, n609, n610,
         n611, n612, n613, n614, n615, n616, n617, n618, n619, n620, n621,
         n622, n623, n624, n625, n626, n627, n628, n629, n630, n631, n632,
         n633, n634, n635, n636, n637, n638, n639, n640, n641, n642, n643,
         n644, n645, n646, n647, n648, n649, n650, n651, n652, n653, n654,
         n655, n656, n657, n658, n659, n660, n661, n662, n663, n664, n665,
         n666, n667, n668, n669, n670, n671, n672, n673, n674, n675, n676,
         n677, n678, n679, n680, n681, n682, n683, n684, n685, n686, n687,
         n688, n689, n690, n691, n692, n693, n694, n695, n696, n697, n698,
         n699, n700, n701, n702, n703, n704, n705, n706, n707, n708, n709,
         n710, n711, n712, n713, n714, n715, n716, n717, n718, n719, n720,
         n721, n722, n723, n724, n725, n726, n727, n728, n729, n730, n731,
         n732, n733, n734, n735, n736, n737, n738, n739, n740, n741, n742,
         n743, n744, n745, n746, n747, n748, n749, n750, n751, n752, n753,
         n754, n755, n756, n757, n758, n759, n760, n761, n762, n763, n764,
         n765, n766, n767, n768, n769, n770, n771, n772, n773, n774, n775,
         n776, n777, n778, n779, n780, n781, n782, n783, n784, n785, n786,
         n787, n788, n789, n790, n791, n792, n793, n794, n795, n796, n797,
         n798, n799, n800, n801, n802, n803, n804, n805, n806, n807, n808,
         n809, n810, n811, n812, n813, n814, n815, n816, n817, n818, n819,
         n820, n821, n822, n823;
  wire   [1:0] spi_mod;
  wire   [2:0] spr;
  wire   [2:0] sppr;
  wire   [11:0] \UNIT1/count ;
  wire   [15:0] \UNIT2/count ;
  wire   [2:0] \UNIT3/count_temp1 ;
  wire   [2:0] \UNIT3/count_temp0 ;
  wire   [7:0] \UNIT3/temp_reg ;
  wire   [2:0] \UNIT3/count_shift1 ;
  wire   [2:0] \UNIT3/count_shift0 ;
  wire   [7:0] \UNIT3/shift_reg ;
  wire   [7:0] \UNIT4/DR ;
  wire   [7:0] \UNIT4/SR ;
  wire   [7:2] \UNIT4/CR2 ;
  wire   [1:0] \UNIT4/APB_PS ;
  assign SS = \UNIT2/count  [14];

  FD2 \UNIT4/APB_PS_reg[1]  ( .D(\UNIT4/APB_NS[1] ), .CP(p_clk), .CD(PRESETn), 
        .Q(\UNIT4/APB_PS [1]), .QN(n810) );
  FD2 \UNIT4/APB_PS_reg[0]  ( .D(n358), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/APB_PS [0]) );
  FD2 \UNIT4/spi_mod_reg[0]  ( .D(n360), .CP(p_clk), .CD(PRESETn), .Q(
        spi_mod[0]) );
  FD2 \UNIT4/spi_mod_reg[1]  ( .D(\UNIT4/SPI_NS[1] ), .CP(p_clk), .CD(PRESETn), 
        .Q(spi_mod[1]) );
  FD2 \UNIT4/DR_reg[7]  ( .D(\UNIT4/N118 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [7]), .QN(n766) );
  FD2 \UNIT4/send_data_reg  ( .D(\UNIT4/N156 ), .CP(p_clk), .CD(PRESETn), .Q(
        send_data), .QN(n784) );
  FD2 \UNIT2/RD_reg  ( .D(\UNIT2/N114 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT2/RD ) );
  FD2 \UNIT2/receive_data_reg  ( .D(\UNIT2/RD ), .CP(p_clk), .CD(PRESETn), .Q(
        receive_data), .QN(n800) );
  FD2 \UNIT4/SR_reg[4]  ( .D(\UNIT4/N124 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/SR [4]) );
  FD2 \UNIT1/MOSI_send_neg_reg  ( .D(\UNIT1/N114 ), .CP(p_clk), .CD(PRESETn), 
        .Q(MOSI_send_neg) );
  FD2 \UNIT1/MISO_receive_neg_reg  ( .D(\UNIT1/N148 ), .CP(p_clk), .CD(PRESETn), .Q(MISO_receive_neg) );
  FD2 \UNIT1/MOSI_send_pos_reg  ( .D(\UNIT1/N113 ), .CP(p_clk), .CD(PRESETn), 
        .Q(MOSI_send_pos) );
  FD2 \UNIT1/MISO_receive_pos_reg  ( .D(\UNIT1/N147 ), .CP(p_clk), .CD(PRESETn), .Q(MISO_receive_pos) );
  FD2 \UNIT1/count_reg[0]  ( .D(\UNIT1/N68 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [0]), .QN(n792) );
  FD2 \UNIT1/count_reg[1]  ( .D(\UNIT1/N69 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [1]), .QN(n767) );
  FD2 \UNIT1/count_reg[2]  ( .D(\UNIT1/N70 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [2]), .QN(n787) );
  FD2 \UNIT1/count_reg[3]  ( .D(\UNIT1/N71 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [3]) );
  FD2 \UNIT1/count_reg[4]  ( .D(\UNIT1/N72 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [4]), .QN(n793) );
  FD2 \UNIT1/count_reg[5]  ( .D(\UNIT1/N73 ), .CP(p_clk), .CD(PRESETn), .QN(
        n788) );
  FD2 \UNIT1/count_reg[6]  ( .D(\UNIT1/N74 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [6]) );
  FD2 \UNIT1/count_reg[7]  ( .D(\UNIT1/N75 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [7]), .QN(n798) );
  FD2 \UNIT1/count_reg[8]  ( .D(\UNIT1/N76 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [8]), .QN(n808) );
  FD2 \UNIT1/count_reg[9]  ( .D(\UNIT1/N77 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [9]), .QN(n789) );
  FD2 \UNIT1/count_reg[10]  ( .D(\UNIT1/N78 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [10]) );
  FD2 \UNIT1/count_reg[11]  ( .D(\UNIT1/N79 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT1/count [11]) );
  FD2 \UNIT3/count_temp0_reg[0]  ( .D(n351), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_temp0 [0]), .QN(n822) );
  FD2 \UNIT3/count_temp0_reg[1]  ( .D(n352), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_temp0 [1]), .QN(n775) );
  FD2 \UNIT3/count_temp0_reg[2]  ( .D(n353), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_temp0 [2]), .QN(n781) );
  FD2 \UNIT3/temp_reg_reg[0]  ( .D(n350), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [0]) );
  FD2 \UNIT3/temp_reg_reg[1]  ( .D(n349), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [1]) );
  FD2 \UNIT3/temp_reg_reg[2]  ( .D(n348), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [2]) );
  FD2 \UNIT3/temp_reg_reg[3]  ( .D(n347), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [3]) );
  FD2 \UNIT3/temp_reg_reg[4]  ( .D(n346), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [4]) );
  FD2 \UNIT3/temp_reg_reg[5]  ( .D(n345), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [5]) );
  FD2 \UNIT3/temp_reg_reg[6]  ( .D(n344), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [6]) );
  FD2 \UNIT3/temp_reg_reg[7]  ( .D(n343), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/temp_reg [7]) );
  FD2 \UNIT3/count_shift0_reg[0]  ( .D(n357), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_shift0 [0]), .QN(n774) );
  FD2 \UNIT3/count_shift0_reg[1]  ( .D(n334), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_shift0 [1]) );
  FD2 \UNIT3/count_shift0_reg[2]  ( .D(n333), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/count_shift0 [2]), .QN(n802) );
  FD2 \UNIT4/DR_reg[0]  ( .D(\UNIT4/N111 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [0]), .QN(n776) );
  FD2 \UNIT4/DR_reg[1]  ( .D(\UNIT4/N112 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [1]), .QN(n770) );
  FD2 \UNIT4/DR_reg[2]  ( .D(\UNIT4/N113 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [2]), .QN(n771) );
  FD2 \UNIT4/DR_reg[3]  ( .D(\UNIT4/N114 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [3]), .QN(n777) );
  FD2 \UNIT4/DR_reg[4]  ( .D(\UNIT4/N115 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [4]), .QN(n778) );
  FD2 \UNIT4/DR_reg[5]  ( .D(\UNIT4/N116 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [5]), .QN(n772) );
  FD2 \UNIT4/DR_reg[6]  ( .D(\UNIT4/N117 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/DR [6]), .QN(n779) );
  FD2 \UNIT4/SR_reg[7]  ( .D(\UNIT4/N209 ), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT4/SR [7]) );
  FD2 \UNIT4/MOSI_data_reg[7]  ( .D(n342), .CP(p_clk), .CD(PRESETn), .QN(n814)
         );
  FD2 \UNIT4/MOSI_data_reg[0]  ( .D(n341), .CP(p_clk), .CD(PRESETn), .QN(n815)
         );
  FD2 \UNIT4/MOSI_data_reg[1]  ( .D(n340), .CP(p_clk), .CD(PRESETn), .QN(n816)
         );
  FD2 \UNIT4/MOSI_data_reg[2]  ( .D(n339), .CP(p_clk), .CD(PRESETn), .QN(n817)
         );
  FD2 \UNIT4/MOSI_data_reg[3]  ( .D(n338), .CP(p_clk), .CD(PRESETn), .QN(n818)
         );
  FD2 \UNIT4/MOSI_data_reg[4]  ( .D(n337), .CP(p_clk), .CD(PRESETn), .QN(n819)
         );
  FD2 \UNIT4/MOSI_data_reg[5]  ( .D(n336), .CP(p_clk), .CD(PRESETn), .QN(n820)
         );
  FD2 \UNIT4/MOSI_data_reg[6]  ( .D(n335), .CP(p_clk), .CD(PRESETn), .QN(n821)
         );
  FD2 \UNIT3/MOSI_reg  ( .D(n332), .CP(p_clk), .CD(PRESETn), .Q(MOSI) );
  FD2 \UNIT4/BR_reg[6]  ( .D(n326), .CP(p_clk), .CD(PRESETn), .QN(n796) );
  FD2 \UNIT4/BR_reg[5]  ( .D(n325), .CP(p_clk), .CD(PRESETn), .Q(sppr[1]), 
        .QN(n803) );
  FD2 \UNIT4/BR_reg[4]  ( .D(n324), .CP(p_clk), .CD(PRESETn), .Q(sppr[0]), 
        .QN(n768) );
  FD2 \UNIT4/BR_reg[2]  ( .D(n323), .CP(p_clk), .CD(n765), .Q(spr[2]), .QN(
        n786) );
  FD2 \UNIT4/BR_reg[1]  ( .D(n322), .CP(p_clk), .CD(n765), .Q(spr[1]), .QN(
        n804) );
  FD2 \UNIT4/BR_reg[0]  ( .D(n321), .CP(p_clk), .CD(n765), .Q(spr[0]), .QN(
        n805) );
  FD2 \UNIT4/CR2_reg[4]  ( .D(n320), .CP(p_clk), .CD(n765), .Q(\UNIT4/CR2 [4]), 
        .QN(n811) );
  FD2 \UNIT4/CR2_reg[3]  ( .D(n319), .CP(p_clk), .CD(n765), .Q(\UNIT4/CR2 [3])
         );
  FD2 \UNIT4/CR2_reg[1]  ( .D(n318), .CP(p_clk), .CD(n765), .Q(SPISWAI) );
  FD2 \UNIT4/CR2_reg[0]  ( .D(n317), .CP(p_clk), .CD(n765), .Q(\UNIT4/CR2_0 )
         );
  FD2 \UNIT4/CR1_reg[6]  ( .D(n316), .CP(p_clk), .CD(n765), .Q(\UNIT4/CR1[6] ), 
        .QN(n813) );
  FD2 \UNIT4/CR1_reg[5]  ( .D(n315), .CP(p_clk), .CD(n765), .QN(n782) );
  FD2 \UNIT4/CR1_reg[4]  ( .D(n314), .CP(p_clk), .CD(n765), .Q(mstr), .QN(n773) );
  FD2 \UNIT4/CR1_reg[3]  ( .D(n313), .CP(p_clk), .CD(n765), .Q(cpol), .QN(n769) );
  FD2 \UNIT4/CR1_reg[1]  ( .D(n312), .CP(p_clk), .CD(n765), .QN(n783) );
  FD2 \UNIT4/CR1_reg[0]  ( .D(n311), .CP(p_clk), .CD(PRESETn), .Q(lsbfe), .QN(
        n780) );
  FD2 \UNIT4/CR1_reg[7]  ( .D(n310), .CP(p_clk), .CD(PRESETn), .QN(n806) );
  FD2 \UNIT3/shift_reg_reg[7]  ( .D(n309), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [7]) );
  FD2 \UNIT3/shift_reg_reg[0]  ( .D(n308), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [0]) );
  FD2 \UNIT3/shift_reg_reg[1]  ( .D(n307), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [1]) );
  FD2 \UNIT3/shift_reg_reg[2]  ( .D(n306), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [2]) );
  FD2 \UNIT3/shift_reg_reg[3]  ( .D(n305), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [3]) );
  FD2 \UNIT3/shift_reg_reg[4]  ( .D(n304), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [4]) );
  FD2 \UNIT3/shift_reg_reg[5]  ( .D(n303), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [5]) );
  FD2 \UNIT3/shift_reg_reg[6]  ( .D(n302), .CP(p_clk), .CD(PRESETn), .Q(
        \UNIT3/shift_reg [6]) );
  FD4 \UNIT4/CR1_reg[2]  ( .D(n301), .CP(p_clk), .SD(PRESETn), .Q(cphase), 
        .QN(n807) );
  FD4 \UNIT3/count_temp1_reg[0]  ( .D(n354), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_temp1 [0]), .QN(n812) );
  FD4 \UNIT3/count_temp1_reg[1]  ( .D(n355), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_temp1 [1]), .QN(n801) );
  FD4 \UNIT3/count_temp1_reg[2]  ( .D(n356), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_temp1 [2]), .QN(n791) );
  FD4 \UNIT3/count_shift1_reg[0]  ( .D(n331), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_shift1 [0]), .QN(n823) );
  FD4 \UNIT3/count_shift1_reg[1]  ( .D(n330), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_shift1 [1]), .QN(n795) );
  FD4 \UNIT3/count_shift1_reg[2]  ( .D(n329), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT3/count_shift1 [2]), .QN(n794) );
  FD4 \UNIT2/count_reg[0]  ( .D(\UNIT2/N73 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [0]) );
  FD4 \UNIT2/count_reg[1]  ( .D(\UNIT2/N74 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [1]) );
  FD4 \UNIT2/count_reg[2]  ( .D(\UNIT2/N75 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [2]) );
  FD4 \UNIT2/count_reg[3]  ( .D(\UNIT2/N76 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [3]) );
  FD4 \UNIT2/count_reg[4]  ( .D(\UNIT2/N77 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [4]), .QN(n799) );
  FD4 \UNIT2/count_reg[5]  ( .D(\UNIT2/N78 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [5]) );
  FD4 \UNIT2/count_reg[6]  ( .D(\UNIT2/N79 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [6]), .QN(n790) );
  FD4 \UNIT2/count_reg[7]  ( .D(\UNIT2/N80 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [7]) );
  FD4 \UNIT2/count_reg[8]  ( .D(\UNIT2/N81 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [8]) );
  FD4 \UNIT2/count_reg[9]  ( .D(\UNIT2/N82 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [9]) );
  FD4 \UNIT2/count_reg[10]  ( .D(\UNIT2/N83 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [10]) );
  FD4 \UNIT2/count_reg[11]  ( .D(\UNIT2/N84 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [11]) );
  FD4 \UNIT2/count_reg[12]  ( .D(\UNIT2/N85 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [12]) );
  FD4 \UNIT2/count_reg[13]  ( .D(\UNIT2/N86 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [13]), .QN(n809) );
  FD4 \UNIT2/count_reg[14]  ( .D(\UNIT2/N87 ), .CP(p_clk), .SD(PRESETn), .Q(
        \UNIT2/count [14]), .QN(n785) );
  FD4 \UNIT4/SR_reg[5]  ( .D(n359), .CP(p_clk), .SD(PRESETn), .Q(\UNIT4/SR [5]) );
  FD3 \UNIT1/s_clk_reg  ( .D(\UNIT1/N80 ), .CP(p_clk), .CD(n327), .SD(n328), 
        .Q(s_clk), .QN(n797) );
  NR2 U429 ( .A(\UNIT4/APB_PS [0]), .B(n810), .Z(PREADY) );
  ND2 U430 ( .A(sppr[0]), .B(sppr[1]), .Z(n365) );
  NR2 U431 ( .A(n796), .B(n365), .Z(n519) );
  IVP U432 ( .A(n519), .Z(n500) );
  NR2 U433 ( .A(spr[1]), .B(n786), .Z(n363) );
  ND2 U434 ( .A(spr[0]), .B(n363), .Z(n389) );
  IVP U435 ( .A(n365), .Z(n364) );
  AO6 U436 ( .A(n768), .B(n803), .C(n364), .Z(n377) );
  IVP U437 ( .A(n377), .Z(n388) );
  ND2 U438 ( .A(spr[0]), .B(spr[1]), .Z(n370) );
  NR2 U439 ( .A(n786), .B(n370), .Z(n518) );
  IVP U440 ( .A(n518), .Z(n499) );
  AO4 U441 ( .A(n500), .B(n389), .C(n388), .D(n499), .Z(n367) );
  AO6 U442 ( .A(n796), .B(n365), .C(n519), .Z(n383) );
  IVP U443 ( .A(n383), .Z(n408) );
  NR2 U444 ( .A(spr[0]), .B(n804), .Z(n368) );
  ND2 U445 ( .A(spr[2]), .B(n368), .Z(n409) );
  NR2 U446 ( .A(n408), .B(n409), .Z(n366) );
  NR2 U447 ( .A(n367), .B(n366), .Z(n496) );
  ND2 U448 ( .A(n368), .B(n786), .Z(n380) );
  NR2 U449 ( .A(spr[0]), .B(spr[1]), .Z(n375) );
  AN2P U450 ( .A(n786), .B(n375), .Z(n371) );
  ND2 U451 ( .A(n786), .B(n370), .Z(n374) );
  NR2 U452 ( .A(n805), .B(n374), .Z(n376) );
  AO2 U453 ( .A(n371), .B(n383), .C(n376), .D(n377), .Z(n369) );
  AO7 U454 ( .A(sppr[0]), .B(n380), .C(n369), .Z(n530) );
  IVP U455 ( .A(n530), .Z(n531) );
  AO2 U456 ( .A(n371), .B(n377), .C(n376), .D(n768), .Z(n477) );
  IVP U457 ( .A(n477), .Z(n471) );
  ND2 U458 ( .A(n371), .B(n768), .Z(n525) );
  IVP U459 ( .A(n525), .Z(n526) );
  NR2 U460 ( .A(n471), .B(n526), .Z(n533) );
  ND2 U461 ( .A(n531), .B(n533), .Z(n397) );
  ND2 U462 ( .A(n383), .B(n376), .Z(n373) );
  NR2 U463 ( .A(n370), .B(spr[2]), .Z(n384) );
  AO2 U464 ( .A(n768), .B(n384), .C(n371), .D(n519), .Z(n372) );
  AO3 U465 ( .A(n388), .B(n380), .C(n373), .D(n372), .Z(n465) );
  NR2 U466 ( .A(n397), .B(n465), .Z(n395) );
  ND2 U467 ( .A(n375), .B(n374), .Z(n387) );
  EO1 U468 ( .A(n519), .B(n376), .C(n408), .D(n380), .Z(n379) );
  ND2 U469 ( .A(n377), .B(n384), .Z(n378) );
  AO3 U470 ( .A(sppr[0]), .B(n387), .C(n379), .D(n378), .Z(n473) );
  IVP U471 ( .A(n473), .Z(n424) );
  ND2 U472 ( .A(n395), .B(n424), .Z(n434) );
  IVP U473 ( .A(n434), .Z(n394) );
  NR2 U474 ( .A(n388), .B(n387), .Z(n382) );
  AO4 U475 ( .A(sppr[0]), .B(n389), .C(n380), .D(n500), .Z(n381) );
  AO1P U476 ( .A(n384), .B(n383), .C(n382), .D(n381), .Z(n486) );
  ND2 U477 ( .A(n394), .B(n486), .Z(n392) );
  EO1 U478 ( .A(n519), .B(n384), .C(n408), .D(n387), .Z(n386) );
  OR2P U479 ( .A(n388), .B(n389), .Z(n385) );
  AO3 U480 ( .A(sppr[0]), .B(n409), .C(n386), .D(n385), .Z(n488) );
  NR2 U481 ( .A(n392), .B(n488), .Z(n431) );
  AO4 U482 ( .A(sppr[0]), .B(n499), .C(n387), .D(n500), .Z(n391) );
  AO4 U483 ( .A(n408), .B(n389), .C(n388), .D(n409), .Z(n390) );
  NR2 U484 ( .A(n391), .B(n390), .Z(n495) );
  AN2P U485 ( .A(n431), .B(n495), .Z(n407) );
  EO U486 ( .A(n496), .B(n407), .Z(n444) );
  NR2 U487 ( .A(\UNIT2/count [12]), .B(n444), .Z(n520) );
  EO U488 ( .A(n488), .B(n392), .Z(n441) );
  NR2 U489 ( .A(\UNIT2/count [10]), .B(n441), .Z(n550) );
  NR2 U490 ( .A(n395), .B(n424), .Z(n393) );
  NR2 U491 ( .A(n394), .B(n393), .Z(n400) );
  NR2 U492 ( .A(\UNIT2/count [8]), .B(n400), .Z(n542) );
  IVP U493 ( .A(n395), .Z(n428) );
  ND2 U494 ( .A(n397), .B(n465), .Z(n467) );
  AN2P U495 ( .A(n428), .B(n467), .Z(n538) );
  NR2 U496 ( .A(n477), .B(n525), .Z(n535) );
  NR2 U497 ( .A(n533), .B(n535), .Z(n541) );
  ND2 U498 ( .A(\UNIT2/count [0]), .B(\UNIT2/count [1]), .Z(n558) );
  IVP U499 ( .A(n558), .Z(n561) );
  ND2 U500 ( .A(n561), .B(\UNIT2/count [2]), .Z(n560) );
  IVP U501 ( .A(n560), .Z(n564) );
  ND2 U502 ( .A(n564), .B(\UNIT2/count [3]), .Z(n563) );
  AN2P U503 ( .A(n563), .B(n799), .Z(n568) );
  NR2 U504 ( .A(n563), .B(n799), .Z(n569) );
  IVP U505 ( .A(n569), .Z(n566) );
  AO7 U506 ( .A(n568), .B(n525), .C(n566), .Z(n396) );
  AO5 U507 ( .A(n541), .B(\UNIT2/count [5]), .C(n396), .Z(n398) );
  AO7 U508 ( .A(n531), .B(n533), .C(n397), .Z(n425) );
  AO5 U509 ( .A(n398), .B(n425), .C(n790), .Z(n399) );
  AO5 U510 ( .A(\UNIT2/count [7]), .B(n538), .C(n399), .Z(n401) );
  EN U511 ( .A(n486), .B(n434), .Z(n402) );
  ND2 U512 ( .A(n402), .B(\UNIT2/count [9]), .Z(n544) );
  ND2 U513 ( .A(\UNIT2/count [8]), .B(n400), .Z(n545) );
  AO3 U514 ( .A(n542), .B(n401), .C(n544), .D(n545), .Z(n403) );
  OR2P U515 ( .A(n402), .B(\UNIT2/count [9]), .Z(n543) );
  ND2 U516 ( .A(n403), .B(n543), .Z(n404) );
  EO U517 ( .A(n495), .B(n431), .Z(n405) );
  ND2 U518 ( .A(n405), .B(\UNIT2/count [11]), .Z(n553) );
  ND2 U519 ( .A(\UNIT2/count [10]), .B(n441), .Z(n524) );
  AO3 U520 ( .A(n550), .B(n404), .C(n553), .D(n524), .Z(n406) );
  OR2P U521 ( .A(n405), .B(\UNIT2/count [11]), .Z(n552) );
  ND2 U522 ( .A(n406), .B(n552), .Z(n410) );
  ND2 U523 ( .A(n407), .B(n496), .Z(n517) );
  AO4 U524 ( .A(n500), .B(n409), .C(n408), .D(n499), .Z(n516) );
  IVP U525 ( .A(n516), .Z(n498) );
  EO U526 ( .A(n517), .B(n498), .Z(n420) );
  IVP U527 ( .A(n420), .Z(n421) );
  ND2 U528 ( .A(n421), .B(\UNIT2/count [13]), .Z(n551) );
  ND2 U529 ( .A(\UNIT2/count [12]), .B(n444), .Z(n521) );
  AO3 U530 ( .A(n520), .B(n410), .C(n551), .D(n521), .Z(n413) );
  ND2 U531 ( .A(n420), .B(n809), .Z(n412) );
  AO1P U533 ( .A(n413), .B(n412), .C(1'b0), .D(\UNIT2/count [14]), .Z(n414) );
  AO6 U534 ( .A(SPISWAI), .B(spi_mod[0]), .C(spi_mod[1]), .Z(n671) );
  AO3 U535 ( .A(send_data), .B(n414), .C(n671), .D(mstr), .Z(\UNIT2/N87 ) );
  IVDA U536 ( .A(PRESETn), .Y(n362), .Z(n765) );
  AO4 U537 ( .A(n769), .B(n807), .C(cphase), .D(cpol), .Z(n676) );
  IVP U538 ( .A(n676), .Z(n677) );
  AO2 U539 ( .A(n677), .B(MOSI_send_neg), .C(MOSI_send_pos), .D(n676), .Z(n743) );
  IVP U540 ( .A(n743), .Z(n720) );
  ND2 U541 ( .A(n780), .B(n720), .Z(n739) );
  NR2 U542 ( .A(\UNIT3/count_shift1 [0]), .B(n739), .Z(n745) );
  AO1P U543 ( .A(n739), .B(\UNIT3/count_shift1 [0]), .C(\UNIT2/count [14]), 
        .D(n745), .Z(n415) );
  IVP U544 ( .A(n415), .Z(n331) );
  NR4 U545 ( .A(\UNIT4/DR [0]), .B(\UNIT4/DR [1]), .C(\UNIT4/DR [2]), .D(
        \UNIT4/DR [3]), .Z(n417) );
  NR4 U546 ( .A(\UNIT4/DR [5]), .B(\UNIT4/DR [6]), .C(\UNIT4/DR [7]), .D(
        \UNIT4/DR [4]), .Z(n416) );
  ND2 U547 ( .A(n417), .B(n416), .Z(\UNIT4/N209 ) );
  IVP U548 ( .A(\UNIT4/N209 ), .Z(n359) );
  NR4 U549 ( .A(\UNIT2/count [14]), .B(n773), .C(n811), .D(n783), .Z(
        \UNIT4/N124 ) );
  NR2 U550 ( .A(\UNIT4/N124 ), .B(\UNIT4/N209 ), .Z(n418) );
  AO4 U551 ( .A(n806), .B(n418), .C(n782), .D(\UNIT4/N209 ), .Z(
        SPI_intrrupt_req) );
  AO3 U552 ( .A(spi_mod[0]), .B(spi_mod[1]), .C(SPISWAI), .D(n813), .Z(n419)
         );
  AO6 U553 ( .A(spi_mod[0]), .B(spi_mod[1]), .C(n419), .Z(\UNIT4/SPI_NS[1] )
         );
  AN4P U554 ( .A(\UNIT4/APB_PS [0]), .B(PENABLE), .C(PSEL), .D(n810), .Z(
        \UNIT4/APB_NS[1] ) );
  AO2 U555 ( .A(n421), .B(n789), .C(\UNIT1/count [9]), .D(n420), .Z(n438) );
  AO2 U556 ( .A(n526), .B(\UNIT1/count [0]), .C(n792), .D(n525), .Z(n476) );
  ND2 U557 ( .A(n538), .B(\UNIT1/count [3]), .Z(n422) );
  AO3 U558 ( .A(n538), .B(\UNIT1/count [3]), .C(n476), .D(n422), .Z(n437) );
  NR2 U559 ( .A(\UNIT1/count [11]), .B(\UNIT1/count [10]), .Z(n474) );
  ND2 U560 ( .A(n541), .B(\UNIT1/count [1]), .Z(n423) );
  AO3 U561 ( .A(n541), .B(\UNIT1/count [1]), .C(n474), .D(n423), .Z(n436) );
  EO1 U562 ( .A(n486), .B(n788), .C(n788), .D(n486), .Z(n481) );
  EO1 U563 ( .A(n495), .B(\UNIT1/count [7]), .C(\UNIT1/count [7]), .D(n495), 
        .Z(n493) );
  AO2 U564 ( .A(n424), .B(n793), .C(\UNIT1/count [4]), .D(n473), .Z(n468) );
  EO1 U565 ( .A(n787), .B(n425), .C(n425), .D(n787), .Z(n427) );
  ND2 U566 ( .A(n428), .B(n468), .Z(n426) );
  AO3 U567 ( .A(n428), .B(n468), .C(n427), .D(n426), .Z(n430) );
  NR2 U568 ( .A(n431), .B(n493), .Z(n429) );
  AO1P U569 ( .A(n431), .B(n493), .C(n430), .D(n429), .Z(n433) );
  ND2 U570 ( .A(n434), .B(n481), .Z(n432) );
  AO3 U571 ( .A(n434), .B(n481), .C(n433), .D(n432), .Z(n435) );
  NR4 U572 ( .A(n438), .B(n437), .C(n436), .D(n435), .Z(n440) );
  ND2 U573 ( .A(n441), .B(\UNIT1/count [6]), .Z(n439) );
  AO3 U574 ( .A(n441), .B(\UNIT1/count [6]), .C(n440), .D(n439), .Z(n443) );
  NR2 U575 ( .A(n444), .B(\UNIT1/count [8]), .Z(n442) );
  AO1P U576 ( .A(n444), .B(\UNIT1/count [8]), .C(n443), .D(n442), .Z(n445) );
  IVP U577 ( .A(n445), .Z(n515) );
  ND2 U578 ( .A(n671), .B(n785), .Z(n527) );
  MUX31L U579 ( .D0(s_clk), .D1(n797), .D2(n769), .A(n515), .B(n527), .Z(
        \UNIT1/N80 ) );
  OR2P U580 ( .A(n527), .B(n445), .Z(n462) );
  NR2 U581 ( .A(\UNIT1/count [0]), .B(n462), .Z(\UNIT1/N68 ) );
  NR2 U582 ( .A(n767), .B(n792), .Z(n446) );
  AO1P U583 ( .A(n767), .B(n792), .C(n446), .D(n462), .Z(\UNIT1/N69 ) );
  IVP U584 ( .A(n446), .Z(n447) );
  NR2 U585 ( .A(n787), .B(n447), .Z(n449) );
  AO1P U586 ( .A(n787), .B(n447), .C(n449), .D(n462), .Z(\UNIT1/N70 ) );
  NR2 U587 ( .A(\UNIT1/count [3]), .B(n449), .Z(n448) );
  AO1P U588 ( .A(\UNIT1/count [3]), .B(n449), .C(n462), .D(n448), .Z(
        \UNIT1/N71 ) );
  ND2 U589 ( .A(\UNIT1/count [3]), .B(n449), .Z(n450) );
  NR2 U590 ( .A(n793), .B(n450), .Z(n451) );
  AO1P U591 ( .A(n793), .B(n450), .C(n451), .D(n462), .Z(\UNIT1/N72 ) );
  IVP U592 ( .A(n451), .Z(n452) );
  NR2 U593 ( .A(n788), .B(n452), .Z(n454) );
  AO1P U594 ( .A(n788), .B(n452), .C(n454), .D(n462), .Z(\UNIT1/N73 ) );
  NR2 U595 ( .A(\UNIT1/count [6]), .B(n454), .Z(n453) );
  AO1P U596 ( .A(\UNIT1/count [6]), .B(n454), .C(n462), .D(n453), .Z(
        \UNIT1/N74 ) );
  ND2 U597 ( .A(\UNIT1/count [6]), .B(n454), .Z(n455) );
  NR2 U598 ( .A(n798), .B(n455), .Z(n457) );
  AO1P U599 ( .A(n798), .B(n455), .C(n457), .D(n462), .Z(\UNIT1/N75 ) );
  NR2 U600 ( .A(\UNIT1/count [8]), .B(n457), .Z(n456) );
  AO1P U601 ( .A(\UNIT1/count [8]), .B(n457), .C(n462), .D(n456), .Z(
        \UNIT1/N76 ) );
  ND2 U602 ( .A(\UNIT1/count [8]), .B(n457), .Z(n458) );
  NR2 U603 ( .A(n789), .B(n458), .Z(n460) );
  AO1P U604 ( .A(n789), .B(n458), .C(n460), .D(n462), .Z(\UNIT1/N77 ) );
  NR2 U605 ( .A(\UNIT1/count [10]), .B(n460), .Z(n459) );
  AO1P U606 ( .A(\UNIT1/count [10]), .B(n460), .C(n462), .D(n459), .Z(
        \UNIT1/N78 ) );
  AN2P U607 ( .A(\UNIT1/count [10]), .B(n460), .Z(n463) );
  NR2 U608 ( .A(\UNIT1/count [11]), .B(n463), .Z(n461) );
  AO1P U609 ( .A(\UNIT1/count [11]), .B(n463), .C(n462), .D(n461), .Z(
        \UNIT1/N79 ) );
  ND2 U610 ( .A(s_clk), .B(n677), .Z(n513) );
  ND2 U611 ( .A(n531), .B(n477), .Z(n464) );
  OR2P U612 ( .A(n465), .B(n464), .Z(n472) );
  ND2 U613 ( .A(\UNIT1/count [3]), .B(n468), .Z(n470) );
  ND2 U614 ( .A(\UNIT1/count [3]), .B(n467), .Z(n466) );
  AO3 U615 ( .A(\UNIT1/count [3]), .B(n467), .C(n472), .D(n466), .Z(n469) );
  AO4 U616 ( .A(n472), .B(n470), .C(n469), .D(n468), .Z(n511) );
  AO2 U617 ( .A(n531), .B(n477), .C(n471), .D(n530), .Z(n484) );
  NR2 U618 ( .A(n473), .B(n472), .Z(n485) );
  IVP U619 ( .A(n485), .Z(n480) );
  AO7 U620 ( .A(n767), .B(n477), .C(n474), .Z(n475) );
  AO1P U621 ( .A(n767), .B(n477), .C(n476), .D(n475), .Z(n479) );
  ND2 U622 ( .A(n481), .B(n480), .Z(n478) );
  AO3 U623 ( .A(n481), .B(n480), .C(n479), .D(n478), .Z(n483) );
  NR2 U624 ( .A(\UNIT1/count [2]), .B(n484), .Z(n482) );
  AO1P U625 ( .A(\UNIT1/count [2]), .B(n484), .C(n483), .D(n482), .Z(n510) );
  ND2 U626 ( .A(n486), .B(n485), .Z(n487) );
  NR2 U627 ( .A(n488), .B(n487), .Z(n494) );
  ND2 U628 ( .A(\UNIT1/count [6]), .B(n494), .Z(n492) );
  ND2 U629 ( .A(n488), .B(n487), .Z(n490) );
  ND2 U630 ( .A(\UNIT1/count [6]), .B(n490), .Z(n489) );
  AO3 U631 ( .A(\UNIT1/count [6]), .B(n490), .C(n493), .D(n489), .Z(n491) );
  AO4 U632 ( .A(n493), .B(n492), .C(n494), .D(n491), .Z(n509) );
  AN2P U633 ( .A(n495), .B(n494), .Z(n497) );
  ND2 U634 ( .A(n496), .B(n497), .Z(n507) );
  AO2 U635 ( .A(n498), .B(n789), .C(\UNIT1/count [9]), .D(n516), .Z(n506) );
  EO1 U636 ( .A(n496), .B(n497), .C(n497), .D(n496), .Z(n503) );
  AO3 U637 ( .A(n500), .B(n499), .C(n498), .D(n497), .Z(n502) );
  NR2 U638 ( .A(n808), .B(n503), .Z(n501) );
  AO2 U639 ( .A(n808), .B(n503), .C(n502), .D(n501), .Z(n505) );
  NR2 U640 ( .A(n507), .B(n506), .Z(n504) );
  AO1P U641 ( .A(n507), .B(n506), .C(n505), .D(n504), .Z(n508) );
  ND4 U642 ( .A(n511), .B(n510), .C(n509), .D(n508), .Z(n512) );
  NR2 U643 ( .A(n513), .B(n512), .Z(\UNIT1/N114 ) );
  ND2 U644 ( .A(n797), .B(n676), .Z(n514) );
  NR2 U645 ( .A(n514), .B(n512), .Z(\UNIT1/N113 ) );
  NR2 U646 ( .A(n515), .B(n513), .Z(\UNIT1/N148 ) );
  NR2 U647 ( .A(n515), .B(n514), .Z(\UNIT1/N147 ) );
  AO2 U648 ( .A(n519), .B(n518), .C(n517), .D(n516), .Z(n523) );
  IVP U649 ( .A(n520), .Z(n522) );
  AO3 U650 ( .A(\UNIT2/count [13]), .B(n523), .C(n522), .D(n521), .Z(n556) );
  IVP U651 ( .A(n524), .Z(n549) );
  OR2P U652 ( .A(send_data), .B(\UNIT2/count [0]), .Z(n557) );
  AO2 U653 ( .A(n526), .B(n799), .C(\UNIT2/count [4]), .D(n525), .Z(n529) );
  ND4 U654 ( .A(mstr), .B(\UNIT2/count [1]), .C(\UNIT2/count [2]), .D(
        \UNIT2/count [3]), .Z(n528) );
  NR4 U655 ( .A(n557), .B(n529), .C(n528), .D(n527), .Z(n540) );
  AO2 U656 ( .A(n531), .B(\UNIT2/count [6]), .C(n790), .D(n530), .Z(n532) );
  ND2 U657 ( .A(n532), .B(\UNIT2/count [5]), .Z(n534) );
  AO4 U658 ( .A(n535), .B(n534), .C(n533), .D(n532), .Z(n537) );
  NR2 U659 ( .A(\UNIT2/count [7]), .B(n538), .Z(n536) );
  AO1P U660 ( .A(\UNIT2/count [7]), .B(n538), .C(n537), .D(n536), .Z(n539) );
  AO3 U661 ( .A(n541), .B(\UNIT2/count [5]), .C(n540), .D(n539), .Z(n548) );
  IVP U662 ( .A(n542), .Z(n546) );
  ND4 U663 ( .A(n546), .B(n545), .C(n544), .D(n543), .Z(n547) );
  NR4 U664 ( .A(n550), .B(n549), .C(n548), .D(n547), .Z(n554) );
  ND4 U665 ( .A(n554), .B(n553), .C(n552), .D(n551), .Z(n555) );
  NR2 U666 ( .A(n556), .B(n555), .Z(\UNIT2/N114 ) );
  IVP U667 ( .A(\UNIT2/N87 ), .Z(n593) );
  ND2 U668 ( .A(n593), .B(n557), .Z(\UNIT2/N73 ) );
  AO3 U669 ( .A(\UNIT2/count [0]), .B(\UNIT2/count [1]), .C(n784), .D(n558), 
        .Z(n559) );
  ND2 U670 ( .A(n593), .B(n559), .Z(\UNIT2/N74 ) );
  AO3 U671 ( .A(n561), .B(\UNIT2/count [2]), .C(n784), .D(n560), .Z(n562) );
  ND2 U672 ( .A(n593), .B(n562), .Z(\UNIT2/N75 ) );
  AO3 U673 ( .A(n564), .B(\UNIT2/count [3]), .C(n784), .D(n563), .Z(n565) );
  ND2 U674 ( .A(n593), .B(n565), .Z(\UNIT2/N76 ) );
  ND2 U675 ( .A(n566), .B(n784), .Z(n567) );
  AO7 U676 ( .A(n568), .B(n567), .C(n593), .Z(\UNIT2/N77 ) );
  ND2 U677 ( .A(\UNIT2/count [5]), .B(n569), .Z(n571) );
  AO3 U678 ( .A(\UNIT2/count [5]), .B(n569), .C(n784), .D(n571), .Z(n570) );
  ND2 U679 ( .A(n593), .B(n570), .Z(\UNIT2/N78 ) );
  NR2 U680 ( .A(n790), .B(n571), .Z(n573) );
  AO1P U681 ( .A(n790), .B(n571), .C(send_data), .D(n573), .Z(n572) );
  OR2P U682 ( .A(\UNIT2/N87 ), .B(n572), .Z(\UNIT2/N79 ) );
  ND2 U683 ( .A(\UNIT2/count [7]), .B(n573), .Z(n575) );
  AO3 U684 ( .A(\UNIT2/count [7]), .B(n573), .C(n784), .D(n575), .Z(n574) );
  ND2 U685 ( .A(n593), .B(n574), .Z(\UNIT2/N80 ) );
  IVP U686 ( .A(n575), .Z(n576) );
  ND2 U687 ( .A(\UNIT2/count [8]), .B(n576), .Z(n578) );
  AO3 U688 ( .A(\UNIT2/count [8]), .B(n576), .C(n784), .D(n578), .Z(n577) );
  ND2 U689 ( .A(n593), .B(n577), .Z(\UNIT2/N81 ) );
  IVP U690 ( .A(n578), .Z(n579) );
  ND2 U691 ( .A(\UNIT2/count [9]), .B(n579), .Z(n581) );
  AO3 U692 ( .A(\UNIT2/count [9]), .B(n579), .C(n784), .D(n581), .Z(n580) );
  ND2 U693 ( .A(n593), .B(n580), .Z(\UNIT2/N82 ) );
  IVP U694 ( .A(n581), .Z(n582) );
  ND2 U695 ( .A(\UNIT2/count [10]), .B(n582), .Z(n584) );
  AO3 U696 ( .A(\UNIT2/count [10]), .B(n582), .C(n784), .D(n584), .Z(n583) );
  ND2 U697 ( .A(n593), .B(n583), .Z(\UNIT2/N83 ) );
  IVP U698 ( .A(n584), .Z(n585) );
  ND2 U699 ( .A(\UNIT2/count [11]), .B(n585), .Z(n587) );
  AO3 U700 ( .A(\UNIT2/count [11]), .B(n585), .C(n784), .D(n587), .Z(n586) );
  ND2 U701 ( .A(n593), .B(n586), .Z(\UNIT2/N84 ) );
  IVP U702 ( .A(n587), .Z(n588) );
  ND2 U703 ( .A(\UNIT2/count [12]), .B(n588), .Z(n590) );
  AO3 U704 ( .A(\UNIT2/count [12]), .B(n588), .C(n784), .D(n590), .Z(n589) );
  ND2 U705 ( .A(n593), .B(n589), .Z(\UNIT2/N85 ) );
  ND2 U706 ( .A(n809), .B(n590), .Z(n591) );
  ND2 U707 ( .A(n784), .B(n591), .Z(n592) );
  ND2 U708 ( .A(n593), .B(n592), .Z(\UNIT2/N86 ) );
  ND2 U709 ( .A(PREADY), .B(PWRITE), .Z(n752) );
  IVP U710 ( .A(n752), .Z(n755) );
  AO4 U711 ( .A(\UNIT3/temp_reg [1]), .B(n770), .C(\UNIT3/temp_reg [3]), .D(
        n777), .Z(n597) );
  AO4 U712 ( .A(\UNIT3/temp_reg [0]), .B(n776), .C(\UNIT3/temp_reg [2]), .D(
        n771), .Z(n596) );
  AO4 U713 ( .A(\UNIT3/temp_reg [6]), .B(n779), .C(\UNIT3/temp_reg [7]), .D(
        n766), .Z(n595) );
  AO4 U714 ( .A(\UNIT3/temp_reg [5]), .B(n772), .C(\UNIT3/temp_reg [4]), .D(
        n778), .Z(n594) );
  NR4 U715 ( .A(n597), .B(n596), .C(n595), .D(n594), .Z(n615) );
  AO2 U716 ( .A(\UNIT3/temp_reg [1]), .B(n770), .C(\UNIT3/temp_reg [0]), .D(
        n776), .Z(n601) );
  AO2 U717 ( .A(\UNIT3/temp_reg [3]), .B(n777), .C(\UNIT3/temp_reg [2]), .D(
        n771), .Z(n600) );
  AO2 U718 ( .A(\UNIT3/temp_reg [6]), .B(n779), .C(\UNIT3/temp_reg [5]), .D(
        n772), .Z(n599) );
  AO2 U719 ( .A(\UNIT3/temp_reg [4]), .B(n778), .C(\UNIT3/temp_reg [7]), .D(
        n766), .Z(n598) );
  ND4 U720 ( .A(n601), .B(n600), .C(n599), .D(n598), .Z(n602) );
  AO2 U721 ( .A(receive_data), .B(n602), .C(\UNIT4/N209 ), .D(n800), .Z(n614)
         );
  IVP U722 ( .A(PWDATA[3]), .Z(n759) );
  AO2 U723 ( .A(\UNIT4/DR [3]), .B(n759), .C(PWDATA[3]), .D(n777), .Z(n606) );
  IVP U724 ( .A(PWDATA[4]), .Z(n758) );
  AO2 U725 ( .A(\UNIT4/DR [4]), .B(n758), .C(PWDATA[4]), .D(n778), .Z(n605) );
  IVP U726 ( .A(PWDATA[1]), .Z(n760) );
  AO2 U727 ( .A(\UNIT4/DR [1]), .B(n760), .C(PWDATA[1]), .D(n770), .Z(n604) );
  IVP U728 ( .A(PWDATA[6]), .Z(n756) );
  AO2 U729 ( .A(\UNIT4/DR [6]), .B(n756), .C(PWDATA[6]), .D(n779), .Z(n603) );
  ND4 U730 ( .A(n606), .B(n605), .C(n604), .D(n603), .Z(n613) );
  NR2 U731 ( .A(PWDATA[7]), .B(n766), .Z(n607) );
  AO1P U732 ( .A(PWDATA[7]), .B(n766), .C(spi_mod[1]), .D(n607), .Z(n611) );
  IVP U733 ( .A(PWDATA[2]), .Z(n763) );
  AO2 U734 ( .A(\UNIT4/DR [2]), .B(n763), .C(PWDATA[2]), .D(n771), .Z(n610) );
  IVP U735 ( .A(PWDATA[0]), .Z(n761) );
  AO2 U736 ( .A(\UNIT4/DR [0]), .B(n761), .C(PWDATA[0]), .D(n776), .Z(n609) );
  IVP U737 ( .A(PWDATA[5]), .Z(n757) );
  AO2 U738 ( .A(\UNIT4/DR [5]), .B(n757), .C(PWDATA[5]), .D(n772), .Z(n608) );
  ND4 U739 ( .A(n611), .B(n610), .C(n609), .D(n608), .Z(n612) );
  AO1P U740 ( .A(n615), .B(n614), .C(n613), .D(n612), .Z(n715) );
  IVP U741 ( .A(n715), .Z(n714) );
  NR2 U742 ( .A(n755), .B(n714), .Z(\UNIT4/N156 ) );
  IVP U743 ( .A(PADDR[0]), .Z(n634) );
  NR2 U744 ( .A(PADDR[1]), .B(n634), .Z(n616) );
  IVP U745 ( .A(PADDR[2]), .Z(n632) );
  ND2 U746 ( .A(n616), .B(n632), .Z(n751) );
  IVP U747 ( .A(n751), .Z(n630) );
  ND2 U748 ( .A(PADDR[2]), .B(n616), .Z(n648) );
  NR2 U749 ( .A(n776), .B(n648), .Z(n620) );
  NR2 U750 ( .A(PADDR[2]), .B(PADDR[0]), .Z(n617) );
  ND2 U751 ( .A(PADDR[1]), .B(n617), .Z(n748) );
  IVP U752 ( .A(n617), .Z(n618) );
  NR2 U753 ( .A(n618), .B(PADDR[1]), .Z(n754) );
  IVP U754 ( .A(n754), .Z(n643) );
  AO4 U755 ( .A(n805), .B(n748), .C(n780), .D(n643), .Z(n619) );
  AO1P U756 ( .A(\UNIT4/CR2_0 ), .B(n630), .C(n620), .D(n619), .Z(n622) );
  IVP U757 ( .A(PWRITE), .Z(n621) );
  ND2 U758 ( .A(PREADY), .B(n621), .Z(n647) );
  NR2 U759 ( .A(n622), .B(n647), .Z(PRDATA[0]) );
  NR2 U760 ( .A(n648), .B(n770), .Z(n624) );
  AO4 U761 ( .A(n804), .B(n748), .C(n643), .D(n783), .Z(n623) );
  AO1P U762 ( .A(n630), .B(SPISWAI), .C(n624), .D(n623), .Z(n625) );
  NR2 U763 ( .A(n625), .B(n647), .Z(PRDATA[1]) );
  AO4 U764 ( .A(n807), .B(n643), .C(n648), .D(n771), .Z(n627) );
  NR2 U765 ( .A(n748), .B(n786), .Z(n626) );
  NR2 U766 ( .A(n627), .B(n626), .Z(n628) );
  NR2 U767 ( .A(n647), .B(n628), .Z(PRDATA[2]) );
  AO4 U768 ( .A(n769), .B(n643), .C(n648), .D(n777), .Z(n629) );
  AO6 U769 ( .A(\UNIT4/CR2 [3]), .B(n630), .C(n629), .Z(n631) );
  NR2 U770 ( .A(n647), .B(n631), .Z(PRDATA[3]) );
  ND2 U771 ( .A(PADDR[1]), .B(n632), .Z(n633) );
  NR2 U772 ( .A(n634), .B(n633), .Z(n645) );
  AO4 U773 ( .A(n773), .B(n643), .C(n648), .D(n778), .Z(n636) );
  AO4 U774 ( .A(n768), .B(n748), .C(n751), .D(n811), .Z(n635) );
  AO1P U775 ( .A(n645), .B(\UNIT4/SR [4]), .C(n636), .D(n635), .Z(n637) );
  NR2 U776 ( .A(n637), .B(n647), .Z(PRDATA[4]) );
  NR2 U777 ( .A(n648), .B(n772), .Z(n639) );
  AO4 U778 ( .A(n803), .B(n748), .C(n643), .D(n782), .Z(n638) );
  AO1P U779 ( .A(\UNIT4/SR [5]), .B(n645), .C(n639), .D(n638), .Z(n640) );
  NR2 U780 ( .A(n640), .B(n647), .Z(PRDATA[5]) );
  AO4 U781 ( .A(n796), .B(n748), .C(n648), .D(n779), .Z(n641) );
  AO6 U782 ( .A(\UNIT4/CR1[6] ), .B(n754), .C(n641), .Z(n642) );
  NR2 U783 ( .A(n647), .B(n642), .Z(PRDATA[6]) );
  AO4 U784 ( .A(n648), .B(n766), .C(n643), .D(n806), .Z(n644) );
  AO6 U785 ( .A(\UNIT4/SR [7]), .B(n645), .C(n644), .Z(n646) );
  NR2 U786 ( .A(n647), .B(n646), .Z(PRDATA[7]) );
  NR2 U787 ( .A(n752), .B(n648), .Z(n666) );
  NR4 U788 ( .A(spi_mod[1]), .B(n755), .C(n715), .D(n800), .Z(n665) );
  AO2 U789 ( .A(n666), .B(PWDATA[0]), .C(\UNIT3/temp_reg [0]), .D(n665), .Z(
        n652) );
  OR2P U790 ( .A(n800), .B(spi_mod[1]), .Z(n649) );
  AO2 U791 ( .A(PREADY), .B(PWRITE), .C(n714), .D(n649), .Z(n650) );
  NR2 U792 ( .A(n666), .B(n650), .Z(n667) );
  ND2 U793 ( .A(\UNIT4/DR [0]), .B(n667), .Z(n651) );
  ND2 U794 ( .A(n652), .B(n651), .Z(\UNIT4/N111 ) );
  AO2 U795 ( .A(n666), .B(PWDATA[1]), .C(\UNIT3/temp_reg [1]), .D(n665), .Z(
        n654) );
  ND2 U796 ( .A(\UNIT4/DR [1]), .B(n667), .Z(n653) );
  ND2 U797 ( .A(n654), .B(n653), .Z(\UNIT4/N112 ) );
  AO2 U798 ( .A(n666), .B(PWDATA[2]), .C(\UNIT3/temp_reg [2]), .D(n665), .Z(
        n656) );
  ND2 U799 ( .A(\UNIT4/DR [2]), .B(n667), .Z(n655) );
  ND2 U800 ( .A(n656), .B(n655), .Z(\UNIT4/N113 ) );
  AO2 U801 ( .A(n666), .B(PWDATA[3]), .C(\UNIT3/temp_reg [3]), .D(n665), .Z(
        n658) );
  ND2 U802 ( .A(\UNIT4/DR [3]), .B(n667), .Z(n657) );
  ND2 U803 ( .A(n658), .B(n657), .Z(\UNIT4/N114 ) );
  AO2 U804 ( .A(n666), .B(PWDATA[4]), .C(\UNIT3/temp_reg [4]), .D(n665), .Z(
        n660) );
  ND2 U805 ( .A(\UNIT4/DR [4]), .B(n667), .Z(n659) );
  ND2 U806 ( .A(n660), .B(n659), .Z(\UNIT4/N115 ) );
  AO2 U807 ( .A(n666), .B(PWDATA[5]), .C(\UNIT3/temp_reg [5]), .D(n665), .Z(
        n662) );
  ND2 U808 ( .A(\UNIT4/DR [5]), .B(n667), .Z(n661) );
  ND2 U809 ( .A(n662), .B(n661), .Z(\UNIT4/N116 ) );
  AO2 U810 ( .A(n666), .B(PWDATA[6]), .C(\UNIT3/temp_reg [6]), .D(n665), .Z(
        n664) );
  ND2 U811 ( .A(\UNIT4/DR [6]), .B(n667), .Z(n663) );
  ND2 U812 ( .A(n664), .B(n663), .Z(\UNIT4/N117 ) );
  AO2 U813 ( .A(n666), .B(PWDATA[7]), .C(\UNIT3/temp_reg [7]), .D(n665), .Z(
        n669) );
  ND2 U814 ( .A(\UNIT4/DR [7]), .B(n667), .Z(n668) );
  ND2 U815 ( .A(n669), .B(n668), .Z(\UNIT4/N118 ) );
  AN2P U816 ( .A(\UNIT2/count [14]), .B(PREADY), .Z(PSLVERR) );
  ND2 U817 ( .A(cpol), .B(n362), .Z(n328) );
  ND2 U818 ( .A(n769), .B(n362), .Z(n327) );
  NR2 U819 ( .A(SPISWAI), .B(spi_mod[0]), .Z(n670) );
  NR2 U820 ( .A(n671), .B(n670), .Z(n672) );
  NR2 U821 ( .A(\UNIT4/CR1[6] ), .B(n672), .Z(n360) );
  IVP U822 ( .A(PSEL), .Z(n675) );
  NR2 U823 ( .A(PENABLE), .B(\UNIT4/APB_PS [1]), .Z(n673) );
  NR2 U824 ( .A(PREADY), .B(n673), .Z(n674) );
  NR2 U825 ( .A(n675), .B(n674), .Z(n358) );
  ND2 U826 ( .A(lsbfe), .B(n720), .Z(n741) );
  NR2 U827 ( .A(n774), .B(n741), .Z(n717) );
  AO1P U828 ( .A(n774), .B(n741), .C(\UNIT2/count [14]), .D(n717), .Z(n357) );
  AO2 U829 ( .A(n677), .B(MISO_receive_neg), .C(MISO_receive_pos), .D(n676), 
        .Z(n680) );
  NR2 U830 ( .A(lsbfe), .B(n680), .Z(n687) );
  ND2 U831 ( .A(n687), .B(n812), .Z(n690) );
  NR2 U832 ( .A(\UNIT3/count_temp1 [1]), .B(n690), .Z(n698) );
  ND2 U833 ( .A(n698), .B(n791), .Z(n678) );
  AO3 U834 ( .A(n698), .B(n791), .C(n785), .D(n678), .Z(n356) );
  ND2 U835 ( .A(\UNIT3/count_temp1 [1]), .B(n690), .Z(n679) );
  AO3 U836 ( .A(\UNIT3/count_temp1 [1]), .B(n690), .C(n785), .D(n679), .Z(n355) );
  AO3 U837 ( .A(n687), .B(n812), .C(n785), .D(n690), .Z(n354) );
  NR2 U838 ( .A(n680), .B(n780), .Z(n683) );
  ND2 U839 ( .A(n683), .B(\UNIT3/count_temp0 [0]), .Z(n686) );
  NR2 U840 ( .A(n775), .B(n686), .Z(n709) );
  NR2 U841 ( .A(\UNIT3/count_temp0 [2]), .B(n709), .Z(n681) );
  AO1P U842 ( .A(\UNIT3/count_temp0 [2]), .B(n709), .C(\UNIT2/count [14]), .D(
        n681), .Z(n353) );
  AO1P U843 ( .A(n775), .B(n686), .C(\UNIT2/count [14]), .D(n709), .Z(n352) );
  NR2 U844 ( .A(n683), .B(\UNIT3/count_temp0 [0]), .Z(n682) );
  AO1P U845 ( .A(n683), .B(\UNIT3/count_temp0 [0]), .C(\UNIT2/count [14]), .D(
        n682), .Z(n351) );
  ND2 U846 ( .A(n683), .B(n822), .Z(n697) );
  NR2 U847 ( .A(\UNIT3/count_temp0 [2]), .B(n697), .Z(n691) );
  AO2 U848 ( .A(n691), .B(n775), .C(n698), .D(n791), .Z(n685) );
  ND2 U849 ( .A(MISO), .B(n785), .Z(n712) );
  ND2 U850 ( .A(n685), .B(\UNIT3/temp_reg [0]), .Z(n684) );
  AO4 U851 ( .A(n685), .B(n712), .C(\UNIT2/count [14]), .D(n684), .Z(n350) );
  NR2 U852 ( .A(\UNIT3/count_temp0 [1]), .B(n686), .Z(n702) );
  ND2 U853 ( .A(n687), .B(\UNIT3/count_temp1 [0]), .Z(n701) );
  NR2 U854 ( .A(\UNIT3/count_temp1 [2]), .B(n701), .Z(n694) );
  AO2 U855 ( .A(n702), .B(n781), .C(n694), .D(n801), .Z(n689) );
  ND2 U856 ( .A(n689), .B(\UNIT3/temp_reg [1]), .Z(n688) );
  AO4 U857 ( .A(n689), .B(n712), .C(\UNIT2/count [14]), .D(n688), .Z(n349) );
  NR2 U858 ( .A(n801), .B(n690), .Z(n706) );
  AO2 U859 ( .A(n691), .B(\UNIT3/count_temp0 [1]), .C(n706), .D(n791), .Z(n693) );
  ND2 U860 ( .A(n693), .B(\UNIT3/temp_reg [2]), .Z(n692) );
  AO4 U861 ( .A(n693), .B(n712), .C(\UNIT2/count [14]), .D(n692), .Z(n348) );
  AO2 U862 ( .A(\UNIT3/count_temp1 [1]), .B(n694), .C(n709), .D(n781), .Z(n696) );
  ND2 U863 ( .A(n696), .B(\UNIT3/temp_reg [3]), .Z(n695) );
  AO4 U864 ( .A(n696), .B(n712), .C(\UNIT2/count [14]), .D(n695), .Z(n347) );
  NR2 U865 ( .A(n781), .B(n697), .Z(n705) );
  AO2 U866 ( .A(\UNIT3/count_temp1 [2]), .B(n698), .C(n705), .D(n775), .Z(n700) );
  ND2 U867 ( .A(n700), .B(\UNIT3/temp_reg [4]), .Z(n699) );
  AO4 U868 ( .A(n700), .B(n712), .C(\UNIT2/count [14]), .D(n699), .Z(n346) );
  NR2 U869 ( .A(n791), .B(n701), .Z(n710) );
  AO2 U870 ( .A(n702), .B(\UNIT3/count_temp0 [2]), .C(n710), .D(n801), .Z(n704) );
  ND2 U871 ( .A(n704), .B(\UNIT3/temp_reg [5]), .Z(n703) );
  AO4 U872 ( .A(n704), .B(n712), .C(\UNIT2/count [14]), .D(n703), .Z(n345) );
  AO2 U873 ( .A(\UNIT3/count_temp1 [2]), .B(n706), .C(\UNIT3/count_temp0 [1]), 
        .D(n705), .Z(n708) );
  ND2 U874 ( .A(n708), .B(\UNIT3/temp_reg [6]), .Z(n707) );
  AO4 U875 ( .A(n708), .B(n712), .C(\UNIT2/count [14]), .D(n707), .Z(n344) );
  AO2 U876 ( .A(\UNIT3/count_temp1 [1]), .B(n710), .C(\UNIT3/count_temp0 [2]), 
        .D(n709), .Z(n713) );
  ND2 U877 ( .A(n713), .B(\UNIT3/temp_reg [7]), .Z(n711) );
  AO4 U878 ( .A(n713), .B(n712), .C(\UNIT2/count [14]), .D(n711), .Z(n343) );
  AO2 U879 ( .A(n715), .B(n766), .C(n814), .D(n714), .Z(n342) );
  AO2 U880 ( .A(n715), .B(n776), .C(n815), .D(n714), .Z(n341) );
  AO2 U881 ( .A(n715), .B(n770), .C(n816), .D(n714), .Z(n340) );
  AO2 U882 ( .A(n715), .B(n771), .C(n817), .D(n714), .Z(n339) );
  AO2 U883 ( .A(n715), .B(n777), .C(n818), .D(n714), .Z(n338) );
  AO2 U884 ( .A(n715), .B(n778), .C(n819), .D(n714), .Z(n337) );
  AO2 U885 ( .A(n715), .B(n772), .C(n820), .D(n714), .Z(n336) );
  AO2 U886 ( .A(n715), .B(n779), .C(n821), .D(n714), .Z(n335) );
  NR2 U887 ( .A(\UNIT3/count_shift0 [1]), .B(n717), .Z(n716) );
  AO1P U888 ( .A(\UNIT3/count_shift0 [1]), .B(n717), .C(\UNIT2/count [14]), 
        .D(n716), .Z(n334) );
  NR2 U889 ( .A(\UNIT2/count [14]), .B(\UNIT3/count_shift0 [1]), .Z(n719) );
  NR2 U890 ( .A(\UNIT2/count [14]), .B(n717), .Z(n718) );
  NR2 U891 ( .A(n719), .B(n718), .Z(n722) );
  ND2 U892 ( .A(\UNIT3/count_shift0 [0]), .B(n802), .Z(n727) );
  ND4 U893 ( .A(lsbfe), .B(\UNIT3/count_shift0 [1]), .C(n785), .D(n720), .Z(
        n721) );
  AO4 U894 ( .A(n722), .B(n802), .C(n727), .D(n721), .Z(n333) );
  AO2 U895 ( .A(\UNIT3/count_shift0 [0]), .B(\UNIT3/shift_reg [7]), .C(
        \UNIT3/shift_reg [6]), .D(n774), .Z(n724) );
  ND2 U896 ( .A(n802), .B(n774), .Z(n725) );
  AO4 U897 ( .A(\UNIT3/shift_reg [2]), .B(n725), .C(\UNIT3/shift_reg [3]), .D(
        n727), .Z(n723) );
  AO6 U898 ( .A(\UNIT3/count_shift0 [2]), .B(n724), .C(n723), .Z(n731) );
  AO2 U899 ( .A(\UNIT3/count_shift0 [0]), .B(\UNIT3/shift_reg [5]), .C(
        \UNIT3/shift_reg [4]), .D(n774), .Z(n726) );
  EO1 U900 ( .A(\UNIT3/count_shift0 [2]), .B(n726), .C(n725), .D(
        \UNIT3/shift_reg [0]), .Z(n730) );
  NR2 U901 ( .A(\UNIT3/shift_reg [1]), .B(n727), .Z(n728) );
  NR2 U902 ( .A(\UNIT3/count_shift0 [1]), .B(n728), .Z(n729) );
  AO2 U903 ( .A(n731), .B(\UNIT3/count_shift0 [1]), .C(n730), .D(n729), .Z(
        n740) );
  AO2 U904 ( .A(\UNIT3/count_shift1 [2]), .B(\UNIT3/shift_reg [7]), .C(
        \UNIT3/shift_reg [3]), .D(n794), .Z(n733) );
  AO2 U905 ( .A(\UNIT3/count_shift1 [2]), .B(\UNIT3/shift_reg [5]), .C(
        \UNIT3/shift_reg [1]), .D(n794), .Z(n732) );
  AO2 U906 ( .A(\UNIT3/count_shift1 [1]), .B(n733), .C(n732), .D(n795), .Z(
        n737) );
  AO2 U907 ( .A(\UNIT3/count_shift1 [2]), .B(\UNIT3/shift_reg [6]), .C(
        \UNIT3/shift_reg [2]), .D(n794), .Z(n735) );
  AO2 U908 ( .A(\UNIT3/count_shift1 [2]), .B(\UNIT3/shift_reg [4]), .C(
        \UNIT3/shift_reg [0]), .D(n794), .Z(n734) );
  AO2 U909 ( .A(\UNIT3/count_shift1 [1]), .B(n735), .C(n734), .D(n795), .Z(
        n736) );
  AO2 U910 ( .A(\UNIT3/count_shift1 [0]), .B(n737), .C(n736), .D(n823), .Z(
        n738) );
  AO4 U911 ( .A(n741), .B(n740), .C(n739), .D(n738), .Z(n742) );
  AO6 U912 ( .A(MOSI), .B(n743), .C(n742), .Z(n744) );
  NR2 U913 ( .A(\UNIT2/count [14]), .B(n744), .Z(n332) );
  ND2 U914 ( .A(n745), .B(n795), .Z(n747) );
  AO3 U915 ( .A(n745), .B(n795), .C(n785), .D(n747), .Z(n330) );
  ND2 U916 ( .A(\UNIT3/count_shift1 [2]), .B(n747), .Z(n746) );
  AO3 U917 ( .A(\UNIT3/count_shift1 [2]), .B(n747), .C(n785), .D(n746), .Z(
        n329) );
  NR2 U918 ( .A(n752), .B(n748), .Z(n750) );
  IVP U919 ( .A(n750), .Z(n749) );
  AO2 U920 ( .A(n750), .B(n756), .C(n796), .D(n749), .Z(n326) );
  AO2 U921 ( .A(n750), .B(n757), .C(n803), .D(n749), .Z(n325) );
  AO2 U922 ( .A(n750), .B(n758), .C(n768), .D(n749), .Z(n324) );
  AO2 U923 ( .A(n750), .B(n763), .C(n786), .D(n749), .Z(n323) );
  AO2 U924 ( .A(n750), .B(n760), .C(n804), .D(n749), .Z(n322) );
  AO2 U925 ( .A(n750), .B(n761), .C(n805), .D(n749), .Z(n321) );
  NR2 U926 ( .A(n752), .B(n751), .Z(n753) );
  EO1 U927 ( .A(n753), .B(n758), .C(\UNIT4/CR2 [4]), .D(n753), .Z(n320) );
  EO1 U928 ( .A(n753), .B(n759), .C(\UNIT4/CR2 [3]), .D(n753), .Z(n319) );
  EO1 U929 ( .A(n753), .B(n760), .C(SPISWAI), .D(n753), .Z(n318) );
  EO1 U930 ( .A(n753), .B(n761), .C(\UNIT4/CR2_0 ), .D(n753), .Z(n317) );
  ND2 U931 ( .A(n755), .B(n754), .Z(n762) );
  IVP U932 ( .A(n762), .Z(n764) );
  AO2 U933 ( .A(n764), .B(n756), .C(n813), .D(n762), .Z(n316) );
  AO2 U934 ( .A(n764), .B(n757), .C(n782), .D(n762), .Z(n315) );
  AO2 U935 ( .A(n764), .B(n758), .C(n773), .D(n762), .Z(n314) );
  AO2 U936 ( .A(n764), .B(n759), .C(n769), .D(n762), .Z(n313) );
  AO2 U937 ( .A(n764), .B(n760), .C(n783), .D(n762), .Z(n312) );
  AO2 U938 ( .A(n764), .B(n761), .C(n780), .D(n762), .Z(n311) );
  EO1 U939 ( .A(n806), .B(n762), .C(n762), .D(PWDATA[7]), .Z(n310) );
  EO1 U940 ( .A(send_data), .B(n814), .C(\UNIT3/shift_reg [7]), .D(send_data), 
        .Z(n309) );
  EO1 U941 ( .A(send_data), .B(n815), .C(\UNIT3/shift_reg [0]), .D(send_data), 
        .Z(n308) );
  EO1 U942 ( .A(send_data), .B(n816), .C(\UNIT3/shift_reg [1]), .D(send_data), 
        .Z(n307) );
  EO1 U943 ( .A(send_data), .B(n817), .C(\UNIT3/shift_reg [2]), .D(send_data), 
        .Z(n306) );
  EO1 U944 ( .A(send_data), .B(n818), .C(\UNIT3/shift_reg [3]), .D(send_data), 
        .Z(n305) );
  EO1 U945 ( .A(send_data), .B(n819), .C(\UNIT3/shift_reg [4]), .D(send_data), 
        .Z(n304) );
  EO1 U946 ( .A(send_data), .B(n820), .C(\UNIT3/shift_reg [5]), .D(send_data), 
        .Z(n303) );
  EO1 U947 ( .A(send_data), .B(n821), .C(\UNIT3/shift_reg [6]), .D(send_data), 
        .Z(n302) );
  AO2 U948 ( .A(n764), .B(n763), .C(n807), .D(n762), .Z(n301) );
endmodule

