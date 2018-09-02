#load package foreign
require(foreign);

#get the data and assign it to variable myData
myData <- read.dta("http://fmwww.bc.edu/ec-p/data/wooldridge/affairs.dta");

#use the factor function to add labels to the kids variable of myData
kids <- factor(myData$kids, labels = c("no", "yes"));

#make a vector containing the different states of happines
marriageLabel <- c("Very Unhappy", "Unhappy", "Average", "Happy", "Very Happy");

#add the labels to the ratemarr variable of myData
marriageRating <- factor(myData$ratemarr, labels = marriageLabel);

#build a table, wether the participants have kids or not, now with yes/no labels
table(kids);

#makes a table containing the happines labels and the corresponding proportion of total answers
prop.table(table(marriageRating));

#make a table cross referencing people who have kids and how happy they are
table(kids, marriageRating);

#make a piechart crossing kids with marriageRatings
pie(table(kids,marriageRating));

#same but now using a bar plot
barplot(table(kids, marriageRating));
