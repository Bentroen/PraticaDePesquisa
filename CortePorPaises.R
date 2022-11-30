pais = list()

for (name in names(gases)) {
  
  data = gases[[name]]
  
  
  # Brasil
  brasil = data |> dplyr::filter((Area.Code==21))
  brasil<-brasil[-1:-7]
  pais <- append(pais, list(brasil))
  names(pais)[length(pais)] = sprintf("%s.%s", name, "brasil")
  

}



x <-as.vector(t(pais$agriculture.CH4.brasil))
sahead <- 1
tsize <- 1
swsize <- 10
preproc <- ts_gminmax()
plot(x)


