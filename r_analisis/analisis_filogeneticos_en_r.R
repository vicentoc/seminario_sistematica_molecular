# Filogenias 
library (ape)

# Un directorio de trabajo
setwd ("C:/Users/vicen/OneDrive/Escritorio/seminario_sistematica_molecular/r_analisis")
# Vector de nombres.
calocitta_names <- c("Sin_12",
                   "Sin_03",
                   "Sin_04",
                   "Sin_15",
                   "Sin_14",
                   "Sin_08",
                   "Sin_09",
                   "Sin_10",
                   "Sin_07",
                   "Sin_11",
                   "Jal_01",
                   "Jal_03",
                   "Sin_05",
                   "Sal_01",
                   "Sal_02",
                   "Gue_03",
                   "Chi_03",
                   "Chi_02",
                   "Chi_01",
                   "Oax_01",
                   "Oax_06",
                   "Mic_01",
                   "Gue_05",
                   "Gue_06",
                   "Oax_12",
                   "Oax_11",
                   "Oax_10",
                   "Oax_09",
                   "Oax_08",
                   "Oax_07",
                   "Nic_01",
                   "Nic_02",
                   "Nic_03",
                   "Nic_04",
                   "Nic_09",
                   "Nic_10",
                   "Nic_11",
                   "Nic_05",
                   "Nic_06",
                   "Nic_07",
                   "Nic_08",
                   "Nic_12",
                   "Nic_13",
                   "Gue_04",
                   "Oax_13",
                   "Gue_01",
                   "Gue_02",
                   "Oax_03",
                   "Oax_05",
                   "Oax_02",
                   "Oax_04",
                   "Jal_02",
                   "Gue_07",
                   "C_cristata",
                   "A_coerulescens",
                   "C_yncas",
                   "P_morio")

# Vector de secuencias.
genebank_access <- c("MW401854", "MW401861",
"MW401864",
"MW401857",
"MW401858",
"MW401860",
"MW401856",
"MW401852",
"MW401862",
"MW401853",
"MW401855",
"MW401871",
"MW401859",
"DQ912602",
"MW401895",
"MW401900",
"MW401877",
"MW401879",
"MW401878",
"MW401865",
"MW401881",
"MW401873",
"MW401874",
"MW401876",
"MW401866",
"MW401867",
"MW401868",
"MW401869",
"MW401870",
"MW401883",
"MW401893",
"MW401894",
"MW401889",
"MW401887",
"MW401891",
"MW401890",
"MW401892",
"MW401896",
"MW401898",
"MW401899",
"MW401897",
"MW401888",
"MW401886",
"MW401875",
"MW401884",
"MW401902",
"MW401901",
"MW401885",
"MW401880",
"MW401903",
"MW401882",
"MW401872",
"HQ123802",
"DQ912604",
"DQ912601",
"GU144847",
"DQ912607")

# From GenenBank
# 
for (i in seq_along (genebank_access)) {
print(paste0("sequence ", i," ", genebank_access [i]))
sequences_calocitta <- read.GenBank(genebank_access[i], seq.names = FALSE, species.names = TRUE)
print(paste0("sequence ", " ", genebank_access [i], " ", "fue descargada ok"))
} 

# Para descargar todas
sequences_calocitta <- read.GenBank(genebank_access, seq.names = FALSE, species.names = TRUE)
  
# Cambiar los nombre con el vector de nombres 
names(sequences_calocitta) <- calocitta_names 
# Save in different formats
write.FASTA(sequences_calocitta , "sequences_calocitta", header = NULL, append = FALSE)

# La red de Haplotipos
library(pegas)
calocitta_haplonet <- read.dna("sequences_calocitta_redhaplotipos")

pop_calocitta <- read.csv("material_suplementario_1.csv")
pop_calocitta_df <- as.data.frame(pop_calocitta)
pop_calocitta_pop <- pop_calocitta_df[1:53,7:8]
population_calocitta <- pop_calocitta_pop$population

haplotipos_calocitta <- haplotype(calocitta_haplonet)
red_calocitta <- haploNet(haplotipos_calocitta)
plot(red_calocitta)

(P_calocitta <- haploFreq(calocitta_haplonet, fac = population_calocitta, haplo = haplotipos_calocitta))
(calocitta.labs <- attr(red_calocitta, "labels"))
(sz_calocitta <- summary(haplotipos_calocitta))
sz_calocitta <- sz_calocitta[calocitta.labs]
P_calocitta <- P_calocitta[calocitta.labs, ]
plot(red_calocitta, size = sz_calocitta, pie = P_calocitta, legend = c(25, 25))
