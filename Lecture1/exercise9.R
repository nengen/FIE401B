#Exercise9

#simulate throwing a one sided coin 100 times
a<-rbinom(100,1000,0.01)
b<-rbinom(100,1000,0.5)

#print first members of a
head(a)

#assign mean of a
ybar<-mean(a)

#assign length of a
n<-length(a)

#assign standard deviation of a 
s<-sd(a)

#to calculate CI
se<-s/sqrt(n)

#find tscore
tscore<-qt(0.975,n-1)

#calculate CI
CI<-c(ybar-tscore*se,ybar+tscore*se)
CI

#Find p value
sp<-sd(b)
t<-(ybar-500)/sp
p<-pt(t, n-1)
p
