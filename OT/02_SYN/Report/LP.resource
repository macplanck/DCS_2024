 
****************************************
Report : resources
Design : LP
Version: T-2022.03
Date   : Thu Jun  6 13:56:17 2024
****************************************


Resource Report for this hierarchy in file
        /RAID2/COURSE/dcs/dcs138/OT/01_RTL/LP.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_inc       | width=8    | add_106 (LP.sv:106)        |
| gt_x_3         | DW_cmp         | width=8    | gt_177 (LP.sv:177)         |
| eq_x_9         | DW_cmp         | width=12   | eq_252 (LP.sv:252)         |
| ne_x_10        | DW_cmp         | width=12   | ne_253 (LP.sv:253)         |
| add_x_11       | DW01_add       | width=12   | add_253_aco (LP.sv:253)    |
| eq_x_12        | DW_cmp         | width=12   | eq_256 (LP.sv:256)         |
| eq_x_13        | DW_cmp         | width=12   | eq_256_2 (LP.sv:256)       |
| gte_x_15       | DW_cmp         | width=12   | gte_301 (LP.sv:301)        |
| gte_x_16       | DW_cmp         | width=12   | gte_326 (LP.sv:326)        |
| lt_x_17        | DW_cmp         | width=12   | lt_356 (LP.sv:356)         |
| sub_x_4        | DW01_sub       | width=12   | sub_181 (LP.sv:181)        |
|                |                |            | sub_186 (LP.sv:186)        |
| DP_OP_52J1_122_4608             |            |                            |
|                | DP_OP_52J1_122_4608 |       |                            |
| DP_OP_53J1_123_4608             |            |                            |
|                | DP_OP_53J1_123_4608 |       |                            |
| DP_OP_54J1_124_4608             |            |                            |
|                | DP_OP_54J1_124_4608 |       |                            |
| DP_OP_56_128_4032               |            |                            |
|                | DP_OP_56_128_4032 |         |                            |
=============================================================================

Datapath Report for DP_OP_52J1_122_4608
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_52J1_122_4608  | mult_300 (LP.sv:300) add_300 (LP.sv:300)            |
|                      | mult_300_2 (LP.sv:300)                              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 12    |                                          |
| I2    | PI   | Signed   | 6     |                                          |
| I3    | PI   | Signed   | 12    |                                          |
| I4    | PI   | Signed   | 6     |                                          |
| T19   | IFO  | Signed   | 12    | I1 * I2 (LP.sv:300)                      |
| T20   | IFO  | Signed   | 12    | I3 * I4 (LP.sv:300)                      |
| O1    | PO   | Unsigned | 12    | T19 + T20 (LP.sv:300)                    |
==============================================================================

Datapath Report for DP_OP_53J1_123_4608
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_53J1_123_4608  | mult_325 (LP.sv:325) add_325 (LP.sv:325)            |
|                      | mult_325_2 (LP.sv:325)                              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 12    |                                          |
| I2    | PI   | Signed   | 6     |                                          |
| I3    | PI   | Signed   | 12    |                                          |
| I4    | PI   | Signed   | 6     |                                          |
| T23   | IFO  | Signed   | 12    | I1 * I2 (LP.sv:325)                      |
| T24   | IFO  | Signed   | 12    | I3 * I4 (LP.sv:325)                      |
| O1    | PO   | Unsigned | 12    | T23 + T24 (LP.sv:325)                    |
==============================================================================

Datapath Report for DP_OP_54J1_124_4608
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_54J1_124_4608  | mult_354 (LP.sv:354) add_354 (LP.sv:354)            |
|                      | mult_354_2 (LP.sv:354)                              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 12    |                                          |
| I2    | PI   | Signed   | 6     |                                          |
| I3    | PI   | Signed   | 12    |                                          |
| I4    | PI   | Signed   | 6     |                                          |
| T27   | IFO  | Signed   | 12    | I1 * I2 (LP.sv:354)                      |
| T28   | IFO  | Signed   | 12    | I3 * I4 (LP.sv:354)                      |
| O1    | PO   | Unsigned | 12    | T27 + T28 (LP.sv:354)                    |
==============================================================================

Datapath Report for DP_OP_56_128_4032
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_56_128_4032    | add_252 (LP.sv:252) sub_243 (LP.sv:243)             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 12    |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 12    | addsub(I1,1,I2) ( LP.sv:243 LP.sv:252 )  |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'add_300 (LP.sv:300)' in design 'LP' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'gte_301 (LP.sv:301)'.  (HDL-120)

Information: Operator associated with resources 'add_325 (LP.sv:325)' in design 'LP' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'gte_326 (LP.sv:326)'.  (HDL-120)

Information: Operator associated with resources 'add_354 (LP.sv:354)' in design 'LP' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'lt_356 (LP.sv:356)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_1            | DW01_inc         | apparch (area)     |                |
| gt_x_3             | DW_cmp           | apparch (area)     |                |
| eq_x_9             | DW_cmp           | apparch (area)     |                |
| ne_x_10            | DW_cmp           | apparch (area)     |                |
| add_x_11           | DW01_add         | apparch (area)     |                |
| eq_x_12            | DW_cmp           | apparch (area)     |                |
| eq_x_13            | DW_cmp           | apparch (area)     |                |
| gte_x_15           | DW_cmp           | apparch (area)     |                |
| gte_x_16           | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| sub_x_4            | DW01_sub         | apparch (area)     |                |
| DP_OP_52J1_122_4608                   |                    |                |
|                    | DP_OP_52J1_122_4608 | str (area)      |                |
|                    |                  | mult_arch: benc_radix4              |
| DP_OP_53J1_123_4608                   |                    |                |
|                    | DP_OP_53J1_123_4608 | str (area)      |                |
|                    |                  | mult_arch: benc_radix4              |
| DP_OP_54J1_124_4608                   |                    |                |
|                    | DP_OP_54J1_124_4608 | str (area)      |                |
|                    |                  | mult_arch: benc_radix4              |
| DP_OP_56_128_4032  | DP_OP_56_128_4032 | str (area,speed)  |                |
===============================================================================

1
