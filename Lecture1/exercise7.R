#Exercise7

x <- seq(0,10,by = 1);
fx <- dbinom(x,10,0.2);
plot(x,fx, type = "h");
y <- pbinom(x,10,0.5);
plot(y);

c <- seq(-2,2, by = 0.1);
normalD <- dnorm(c,mean = 0,sd = 1);
plot(normalD);
normalDCDF <- pnorm(c,mean = 0,sd = 1);
plot(normalDCDF);
print(normalDCDF)
#cdf of 1 in normal dist
print(pnorm(1, mean = 0, sd = 1));
z <- qnorm(0.975, mean = 0, sd = 1);
print(z);

 