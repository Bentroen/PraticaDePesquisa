source("https://raw.githubusercontent.com/eogasawara/mylibrary/24fb964fa218aa6e3db181599f08081f8d2c1241/myBasic.R")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/24fb964fa218aa6e3db181599f08081f8d2c1241/myTSRegression.R")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/24fb964fa218aa6e3db181599f08081f8d2c1241/myPreprocessing.R")

x <-as.vector(t(pais_brasil$energy.CO2.brasil))
sahead <- 1
tsize <- 1
swsize <- 10
preproc <- ts_gminmax()
plot(x)



train_test <- function(x, model, sw_size, test_size, steps_ahead) {
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
  plot(model, y=yvalues, yadj=adjust, ypre=prediction)
  return(model)
}


xlabels = 1990:2017


model <- train_test(x, model=tsreg_arima(), 0, 
                    test_size = tsize, steps_ahead = sahead)

model <- train_test(x, model=tsreg_rf(preproc, input_size=4, mtry=3, ntree=50), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#random forest

model <- train_test(x, model=tsreg_mlp(preproc, input_size=4, size=4, decay=0), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#neural network

model <- train_test(x, model=tsreg_svm(preproc, input_size=4, epsilon=0.0, cost=80.00), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#svm

model <- train_test(x, model=tsreg_elm(preproc, input_size=4, nhid=3,actfun="purelin"), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#elm

model <- train_test(x, model=tsreg_cnn(preproc, input_size=4, neurons=16,epochs=200), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#cnn

model <- train_test(x, model=tsreg_lstm(preproc, input_size=4, neurons=32, epochs=200), 
                    sw = swsize, test_size = tsize, steps_ahead = sahead)#lstm

for(i in 1:15){
  model <- train_test(x, model=tsreg_lstm(preproc, input_size=4, neurons=32, epochs=200), 
                      sw = swsize, test_size = tsize, steps_ahead = sahead)
}