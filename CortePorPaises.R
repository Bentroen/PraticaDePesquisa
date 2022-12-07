pais_japao = list()

for (name in names(gases)) {
  
  data = gases[[name]]
  
  
  # Brasil
  japao = data |> dplyr::filter((Area.Code==110))
  japao<-japao[-1:-7]
  pais_japao <- append(pais_japao, list(japao))
  names(pais_japao)[length(pais_japao)] = sprintf("%s.%s", name, "india")
  

}

save(pais_brasil,file="./rdata/brasil_series.RData",compress=TRUE)

save(pais_china,file="./rdata/china_series.RData",compress=TRUE)

save(pais_japao,file="./rdata/japao_series.RData",compress=TRUE)

save(pais_usa,file="./rdata/usa_series.RData",compress=TRUE)

save(pais_india,file="./rdata/india_series.RData",compress=TRUE)

save(pais_russia,file="./rdata/russia_series.RData",compress=TRUE)

x <-as.vector(t(pais_india$energy.CO2.india))
sahead <- 1
tsize <- 1
swsize <- 10
preproc <- ts_gminmax()
plot(x,main="India_Energy_CO2",ylab="Emissões",xlab="Total de anos")


