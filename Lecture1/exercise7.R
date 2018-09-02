#Exercise7

x <- seq(0,10,by = 1);

#probability density function at each point
fx <- dbinom(x,10,0.5);

#plot the function using x as the points, h = histogram, as we can see it follows normal dist
plot(x,fx, type = "h");

#cumulative probability
y <- pbinom(x,10,0.5);
plot(y, type= "l");


c <- seq(-2,2, by = 0.1);

#probability distribution, normal dist
normalD <- dnorm(c,mean = 0,sd = 1);
plot(normalD);

#cumulative probability distribution, normal dist
normalDCDF <- pnorm(c,mean = 0,sd = 1);
plot(normalDCDF);
print(normalDCDF)


#cdf of 1 in normal dist
print(pnorm(1, mean = 0, sd = 1));

#find z value of 0.975% of area under cdf
z <- qnorm(0.975, mean = 0, sd = 1);
print(z);

 