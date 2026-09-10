#Load Required Packages
library(ggplot2)
library(dplyr)
library(car)

#Load the dataset
baseball <- read.csv("data/baseball.csv")

#### Question 1: Relationship Between OBP and Wins
Scatter.Plot<-ggplot(baseball, aes(W, OBP)) +geom_point(color= "mediumpurple1") + 
geom_smooth(method = "lm", color="gray20")  +xlab("Number of Wins") + 
ylab("On-Base Percentage (OBP)") + ggtitle("Correlation of Wins to OBP") +
theme(plot.title = element_text(face="bold", size=(20), color = "gray0"))   + 
theme(plot.title = element_text(hjust = 0.5))

Scatter.Plot

#### Checking if the variables follow a normal distribution
Wins.Hist <- ggplot(baseball,aes(W)) + geom_histogram(fill="deepskyblue", color="dimgray") +
xlab("Wins") + ylab("Number of Teams") + ggtitle("Spread of Wins") +
theme(plot.title = element_text(face="bold", size=(20), color = "gray0")) +
  theme(plot.title = element_text(hjust = 0.5))

Wins.Hist

OBP.Hist <- ggplot(baseball,aes(OBP)) + geom_histogram(fill="darkslategray2", color="darkslategray") +
xlab("On-Base Percentage(OBP)") + ylab("Number of Teams") + ggtitle("Spread of OBP") +
theme(plot.title = element_text(face="bold", size=(20), color = "gray0")) +
theme(plot.title = element_text(hjust = 0.5))

OBP.Hist

shapiro.test(baseball$W) #p-value is less than 0.05 so it does not follow a normal distribution
shapiro.test(baseball$OBP)

#### Seeing the Correlation using Spearman as the Wins data was not normal
r1 = rank(baseball$W)
r2 = rank(baseball$OBP)
cor(r1,r2)

#### Regression Model 

Model.1<-lm(W~OBP, data=baseball)
summary(Model.1)


#### Check if the assumptions of a linear regression model are met

# Linearity Assumption
plot(Model.1,1)

# Normality Assumption
plot(Model.1,2)

# Homoscedasticity Assumption
plot(Model.1,3)


#### Question 2: Relationship Between OBP and Wins

# Convert playoff status into a categorical variable
playoffs <-as.factor(baseball$Playoffs)
levels(playoffs) <- c("No", "Yes")

# Visualize batting average for playoff vs. non-playoff teams

BA.Playoffs.Box <- ggplot(baseball,aes(playoffs,BA)) + geom_boxplot(aes(fill=playoffs)) + 
  xlab("Playoff Appreance") + ylab("Batting Average (BA)") +
  ggtitle("Spread of BA in Non-Playoff Teams vs Playoff Teams") +
  theme(plot.title = element_text(face="bold", size=(14), color = "gray0")) +
  theme(plot.title = element_text(hjust = 0.5))

BA.Playoffs.Box

# Compare batting average distributions
BA.Playoffs.Hist <- ggplot(baseball,aes(BA, fill=playoffs)) +geom_histogram() + facet_wrap(~Playoffs) + 
  xlab("Batting Average(BA)") + ylab("Number of Teams") +
  ggtitle("Spread of BA in Non-Playoff Teams vs Playoff Teams") +
  theme(plot.title = element_text(face="bold", size=(14), color = "gray0")) +
  theme(plot.title = element_text(hjust = 0.5))

BA.Playoffs.Hist



# One-Way Anova Test
Model.2<-aov(BA~playoffs, data=baseball)
summary(Model.2)

### Assumptions 

#Check the homogeneity of variance assumption
leveneTest(BA ~ playoffs,data=baseball )
bartlett.test(BA~playoffs, data=baseball)

# Check the normality assumption
plot(Model.2,2)

# Homogeneity of variance assumption was not met therefore we do a Kruskal Test
kruskal.test(BA ~ Playoffs, data=baseball)

# Point Biserial Correlation
cor.test(baseball$BA, baseball$Playoffs)

#### Subsetting and Comparing Playoff & Non-Playoff Teams
Playoff.Teams<- baseball %>% filter(Playoffs==1)  %>% select(Year| Team | BA)
summary(Playoff.Teams)
Max <- Playoff.Teams  %>% filter(BA == max(BA))   %>% select( Year |Team | BA )
Min <-  Playoff.Teams  %>% filter(BA == min(BA))   %>% select( Year |Team |BA)
Median <- Playoff.Teams  %>% filter(BA == median(BA))   %>% select( Year |Team | BA)

Non.Playoff.Teams <- baseball %>% filter(Playoffs==0)  %>% select(Year| Team | BA)
summary(Non.Playoff.Teams)
Non.Max <- Non.Playoff.Teams  %>% filter(BA == max(BA))   %>% select( Year |Team | BA )
Non.Min <-  Non.Playoff.Teams  %>% filter(BA == min(BA))   %>% select( Year |Team |BA)
Non.Median <- Non.Playoff.Teams  %>% filter(BA == median(BA))   %>% select( Year |Team | BA)




