require(foreign);
myData <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta");
new <- myData [myData$age>=32,];
head(myData);
str(myData);

