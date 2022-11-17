
library(dplyr)

# load_series <- function(name) {
#   link <- url(sprintf("https://raw.githubusercontent.com/Bentroen/PraticaDe/master/data/time-series/%s.RData", name))
#   x <- get(load(link))
#   return(x)  
# }
# x <- load_series("Brazil.P2O5")
# sahead <- 1
# tsize <- 1
# swsize <- 10
# preproc <- ts_gminmax()
# plot(x)

load_series <- function(name) {
  x <- get(load(sprintf("./rdata/%s.RData", name)))
  return(x)
}

filter <- function(area, item, element) {
  
}


dataset <- load_series("Environment_Emissions_by_Sector_E_All_Data")

unique(dataset$Element)
y <- dataset |> dplyr::filter((Area.Code == 21))
y <- dataset |> dplyr::filter(
                                ((Element == "CO2 emissions") | (Element == "N2O emissions") | (Element == "CH4 emissions")) & 
                                ((Area.Code == 5000)))

save(y, file="./rdata/World.RData", compress=TRUE)

