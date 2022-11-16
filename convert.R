setwd("./PraticaDePesquisa")

filenames <- c(
  "Environment_Emissions_by_Sector_E_All_Data",
  "Environment_Emissions_by_Sector_E_All_Data_NOFLAG",
  "Environment_Emissions_by_Sector_E_Flags",
  "Environment_LandUse_E_All_Data",
  "Environment_LandUse_E_All_Data_NOFLAG",
  "Environment_LandUse_E_Flags"
)

# Create output folder
if (!dir.exists(file.path(getwd(), "rdata"))) {
  dir.create(file.path(getwd(), "rdata"))
}

for (f in filenames) {
  infile = paste("./data/", f, ".csv", sep="", collapse=NULL)
  outfile = paste("./rdata/", f, ".RData", sep="", collapse=NULL)
  
  file_data = read.table(infile, header=TRUE, sep=",")
  
  for (year in 1960:1989) {
    col = sprintf("Y%s", year)
    col_f = paste(col, "F", sep="")
    file_data[[col]] <- NULL
    file_data[[col_f]] <- NULL
    head(file_data)
  }

  save(file_data, file=outfile, compress=TRUE)
  
}

