#Exercise8
#rnorm creates random numbers
#set.seed makes the random numbers stay constant, changing value in set.seed() changes random numbers

rnorm(10, mean = 0, sd = 1);
set.seed(100);
x1 <- mean(rnorm(10, mean = 0, sd = 1));
print(x1);
set.seed(1000)
x2 <- mean(rnorm(10, mean = 0, sd = 1));
print(x2);

rnorm(1000, mean = 0, sd = 1);
set.seed(100);
x3 <- mean(rnorm(1000, mean = 0, sd = 1));
print(x3);


