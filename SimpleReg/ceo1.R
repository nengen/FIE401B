require(foreign);
ceo <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1.dta");
fit <- lm(salary~roe, data = ceo);
summary(fit);
