#If (condition){command for execution} else{command for execution}
#For (loopvariable){command for execution}
#Function name<-function(independent variable names){
#  Dependent variable name<-f(independent variable name)
#  return(Dependent variable name)
#}

x <- 9;
  
#if syntax
if (x >= 0){
  print(sqrt(x));
}else{
  print("error, x must be greater than 0");
}

#for syntax
for (x in c(1:6)){
  print(x^2);
}
