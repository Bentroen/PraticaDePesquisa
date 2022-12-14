# install.packages('forecast')
# install.packages("TSPred")

source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myBasic.R")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myTSRegression.R")

x <-as.vector(t(pais_india$energy.CO2.india))

train_test <- function(x, model, sw_size, test_size, steps_ahead, xlabels) {
  ts <- ts_data(x, sw_size)
  
  samp <- ts_sample(ts, test_size)
  
  io_train <- ts_projection(samp$train)
  
  model <- fit(model, x=io_train$input, y=io_train$output)
  
  adjust <- predict(model, io_train$input)
  ev_adjust <- evaluation.tsreg(io_train$output, adjust)
  print(head(ev_adjust$metrics))
  
  io_test <- ts_projection(samp$test)
  
  prediction <- predict(model, x=io_test$input, steps_ahead=steps_ahead)
  output <- as.vector(io_test$output)
  if (steps_ahead > 1)
    output <- output[1:steps_ahead]
  ev_prediction <- evaluation.tsreg(output, prediction)
  print(head(ev_prediction$metrics))
  
  prep <- ""
  if (!is.null(model$preprocess))
    prep <- sprintf("-%s", class(model$preprocess)[1])    
  
  print(sprintf("%s%s %.2f", class(model)[1], prep, 100*ev_prediction$metrics$smape))

  yvalues <- c(io_train$output, io_test$output)
  plot(model, y=yvalues, yadj=adjust, ypre=prediction, xlabels=xlabels)
  return(model)
}


xlabels = 1990:2017

model <- train_test(x, model=tsreg_arima(), 0, 
                    test_size = tsize, steps_ahead = sahead, xlabels=xlabels)
