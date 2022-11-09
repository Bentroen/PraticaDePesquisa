setcwd("./PraticaDePesquisa")

filenames <- c(
  "Environment_Emissions_by_Sector_E_All_Data",
  "Environment_Emissions_by_Sector_E_All_Data_NOFLAG",
  "Environment_Emissions_by_Sector_E_Flags",
  "Environment_LandUse_E_All_Data",
  "Environment_LandUse_E_All_Data_NOFLAG",
  "Environment_LandUse_E_Flags"
)

for (f in filenames) {
  infile = paste("./data/", f, ".csv", sep="", collapse=NULL)
  outfile = paste("./rdata/", f, ".RData", sep="", collapse=NULL)
  
  file_data = read.table(infile, header=TRUE, sep=",")
  save(file_data, file=outfile, compress=TRUE)
}



