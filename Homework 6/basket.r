library(arules)
library(arulesViz)
setwd("/home/vkg/IIT/CS422/lectures/association-analysis/")
rm(list=ls())

#### Read the data directly in as **transactions** and inspect them.
trans <- read.transactions("mba-2.csv", sep=",")
summary(trans)

#### See the first 5 items in the transactions database
inspect(trans[1:5])

#### If you want to see frequent itemsets with particular support, you would 
#### do the following:
f_is <- apriori(trans, parameter=list(support=0.09, target="frequent itemsets"))
inspect(sort(f_is, decreasing = T, by="count"))
rm(f_is)

#### Get familiar with the data
itemFrequencyPlot(trans, support = 0.1)
image(trans)

### Now, let's run Apriori on the dataset. Note that we only get one rule.  Why?
rules <- apriori(trans)
inspect(head(rules, by="confidence"))
rm(rules)

#### We get one rule since our minsup is set too high (0.1).  Let's reduce it.
rules <- apriori(trans, parameter = list(support=0.01))
summary(rules)

#### Let's inspect the rules, sorted by confidence
inspect(head(rules, by="confidence"))

#### We can even interactively plot the rules and examine them.
plot(rules, engine="htmlwidget")

#### You can drill down into rules that have a certain consequent you are 
#### looking for as follows:
rules.beer <- apriori(trans, parameter=list(supp=0.01),
                 appearance = list(default="lhs", rhs="beer"))
inspect(sort(rules.beer, decreasing = T, by="support"))
