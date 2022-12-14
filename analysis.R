getwd()
load_series <- function(name) {
  x <- get(load(sprintf("./rdata/%s.RData", name)))
  return(x)
}


library(dplyr)
dataset <- load_series("Environment_Emissions_by_Sector_E_All_Data_NOFLAG")

unique(dataset$Element)
y <- dataset |> dplyr::filter((Area.Code == 21))
y <- dataset |> dplyr::filter(
  ((Element == "CO2 emissions") | (Element == "N2O emissions") | (Element == "CH4 emissions")) & 
    ((Area.Code == 5000)))


# Filtrar territórios com código < 5000 (países)
dataset = dataset |> dplyr::filter((Area.Code < 5000))

# Separar emissões por setor
sectors = list(
  agriculture = dataset |> dplyr::filter((Item == "Agriculture total")),
  industry = dataset |> dplyr::filter((Item == "Industrial processes and product use")),
  energy =  dataset |> dplyr::filter((Item == "Energy"))
)

# Separar emissões de setores por gases
gases = list()
for (name in names(sectors)) {
  data = sectors[[name]]
  
  # CO2
  co2 = data |> dplyr::filter((Element == "CO2 emissions"))
  gases <- append(gases, list(co2))
  names(gases)[length(gases)] = sprintf("%s.%s", name, "CO2")
  
  # CH4
  ch4 = data |> dplyr::filter((Element == "CH4 emissions"))
  gases <- append(gases, list(ch4))
  names(gases)[length(gases)] = sprintf("%s.%s", name, "CH4")
  
  # N2O
  n2o = data |> dplyr::filter((Element == "N2O emissions"))
  gases <- append(gases, list(n2o))
  names(gases)[length(gases)] = sprintf("%s.%s", name, "N2O")
}

# Salvar RData das emissões
f = "Emissions_by_sector_CO2_CH4_N2O"
outfile = paste("./rdata/", f, ".RData", sep="", collapse=NULL)
save(gases, file=outfile, compress=TRUE)


co2_emissions = dataset |> dplyr::filter((Element == "CO2 emissions"))
ch4_emissions = dataset |> dplyr::filter((Element == "NH4 emissions"))
n2o_emissions = dataset |> dplyr::filter((Element == "N2O emissions"))

save(y, file="./rdata/World.RData", compress=TRUE)




# PRÓXIMO PASSO:
# 2) Somar colunas 1990-2017
# 3) Extrair os 10 maiores


df %>%
  replace(is.na(.), 0) %>%
  mutate(sum = rowSums(across(where(is.numeric))))