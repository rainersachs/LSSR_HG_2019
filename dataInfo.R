# Copyright:    (C) 2017-2019 Sachs Undergraduate Research Apprentice Program
#               This program and its accompanying materials are distributed 
#               under the terms of the GNU General Public License v3.
# Filename:     dataInfo.R 
# Purpose:      Concerns radiogenic mouse Harderian gland tumorigenesis. Loads 
#               ion and tumor prevalence data from CSV files. It is part of the 
#               source code for the Harderian Gland LSSR project.
# Contact:      Rainer K. Sachs 
# Website:      https://github.com/rainersachs/LSSR_HG_2019
# Mod history:  24 Dec 2019
# Attribution:  This R script was developed at UC Berkeley. Written by Dae Woong 
#               Ham Summer 2017. Additions, corrections, changes, quality 
#               control, and reorganization were made by Edward Greg Huang, 
#               Yimin Lin, Mark Ebert, Yunzhi Zhang, and Ray Sachs from 
#               2017 - 2018. Additional contributions to the project were made 
#               by Ren-Yi Wang, Liyang Xie, Gracie Yao, and Borong Zhang 
#               during 2019.

# Relevant references and abbreviations:
#
#   ".93Alp" = Alpen et al. "Tumorigenic potential of high-Z, high-LET charged-
#                           particle radiations." Rad Res 136:382-391 (1993).
#
#   ".94Alp" = Alpen et al. "Fluence-based relative biological effectiveness for
#                           charged particle carcinogenesis in mouse Harderian 
#                           gland." Adv Space Res 14(10): 573-581. (1994).  
#
#   "16Chang" = Chang et al. "Harderian Gland Tumorigenesis: Low-Dose and LET 
#                            Response." Radiat Res 185(5): 449-460. (2016). 
#
#   "16Srn" = Siranart et al. "Mixed Beam Murine Harderian Gland Tumorigenesis: 
#                             Predicted Dose-Effect Relationships if neither 
#                             Synergism nor Antagonism Occurs." 
#                             Radiat Res 186(6): 577-591 (2016).  
#
#   "17Cuc" = Cucinotta & Cacao. "Non-Targeted Effects Models Predict 
#                                Significantly Higher Mars Mission Cancer Risk 
#                                than Targeted Effects Models." 
#                                Sci Rep 7(1): 1832. (2017). PMC5431989
#
#   "HZE"     = High atomic number and energy
#   "LET"     = Linear energy transfer
#   "NTE"     = Non-targeted effects
#   "TE"      = Targeted effects
#   "DER"     = Dose-effect relation(ship)"
#   "MIXDER"  = Mixture baseline DER
#   "SEA"     = Simple Effect Additivity
#   "IEA"     = Incremental Effect Additivity
#   "cGy"     = Centigray

# Data used in 16Chang; includes data analyzed in .93Alp and .94Alp. Does not 
# include gamma-ray data. Includes LET=100 keV/micron for Ti, an ad-hoc 
# compromise between lower value at beam entry and higher value at mouse cage.

# The next few lines plus the CSV file (which will need work as 
# additions and perhaps corrections come up) should be all we need.
ion_data <- data.frame(read.csv("oneIon.csv")) 
mix_data <- data.frame(read.csv("mixIon.csv"))
controls_data <- data.frame(read.csv("controls.csv"))
Y_0 <- controls_data[10, 4] # background prevalence

# The following, which shows how to compute ion speed and the Katz 
# amorphous track structure parameter, may be used for adding Cucinotta's 
# models in 16 Chang to our scripts and comparing them to our more 
# parsimonious models.

# GeVu is kinetic energy per atomic mass unit. An example for 
# 670Ne20 is GeVu = 10^-3*670.

# The calculations here can and will approximate Z_eff by Z, 
# e.g. Z_eff = 10 for Ne.

# Katz = 1/round(Z^2 * (2.57 * GeVu^2 + 4.781 * GeVu + 2.233) / 
# (2.57 * GeVu^2 + 4.781 * GeVu), 3) 

# Special relativistic calculation of Z^2 / beta^2. The numerics include 
# conversion from GeV to joules and from u to kg.

# beta_star = Z * round(sqrt(1 / Katz), 3) 
# i.e. beta = Z * sqrt(beta^2 / Z^2).

message("dataInfo.R sourced.")
