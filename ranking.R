library(magrittr)
library(dplyr)

ranked = dataset |> dplyr::filter(
  (
    #(Item == "Agriculture total") |
    #(Item == "Industrial processes and product use") |
    (Item == "Energy")
  ) & (
    (Element == "CO2 emissions") #|
    #(Element == "CH4 emissions") |
    #(Element == "N2O emissions")
  )
)
ranked <- ranked[,-3:-7]
ranked <- ranked[,-1]

# eliminating NA values
ranked <- ranked %>%                      
  replace(is.na(.), 0)

somaranked <- apply(ranked[,2:ncol(ranked)],1,sum)

sort(somaranked,decreasing=TRUE)

ranked["soma"]<-somaranked

somas <-ranked[,-2:-29]

somas<-somas[order(somas$soma, decreasing = TRUE)]
j<-order(somas$soma,decreasing=TRUE)
somasord<-somas[j,]

rank <- head(somasord, 10)