#datalab
data <- read.csv("Method_of_payment.csv", header=TRUE, sep=",")
data$adjustedMTB <- data$bidder_mtb-data$med_mtb_sect

data_win <- as.data.frame(apply(data[,c("adjustedMTB","relsize","bidder_lev","bidder_tang","bidder_cash","bidder_rd","rate","lbidder_size")],MARGIN=2,Winsorize,probs=c(0.005,0.995)))

#combine winsorized and dummy variables
data <- cbind(data[,c("yyyy", "public", "all_stock", "horz", "domestic", "post")], data_win)
rm(data_win)

lpm <- lm(all_stock~adjustedMTB, data = data) #estimate lpm with single regressor

bptest(lpm) #check heteroskedasticity
coeftest(lpm) #dont need to correct
