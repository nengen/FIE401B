require(foreign);
dat = read.csv("/Users/Nengen/Downloads/STATOIL.csv", header = TRUE);
summary(dat);
hist(dat$Volume);
plot(density(dat$Volume));
plot(ecdf(dat$Volume));
boxplot(dat$Open);
cor(dat$Volume, dat$Open);
cov(dat$Volume, dat$Open);
summary(dat);

