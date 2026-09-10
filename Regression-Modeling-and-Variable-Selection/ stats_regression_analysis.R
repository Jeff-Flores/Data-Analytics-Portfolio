# Study 1
Fire=Fires
summary(Fire); dim(Fire); head(Fire)
Distance=Fire$DISTANCE
Damage=Fire$DAMAGE
Fires_Model<- lm(Damage~Distance)
summary(Fires_Model)


# Linearity Assumption:No violation of Linearity/Equal Variance is shown as the points show no pattern
plot(residuals(Fires_Model) ~ fitted.values(Fires_Model), xlab= "Predicted Values", ylab="Residuals", main="Predicted vs. Residuals");abline(h=0, col = "red", lty=4)
plot(Fires_Model,1)

# Normal Population Assumption: No violation of Normality is shown as the points show a straight-line pattern
qqnorm(residuals(Fires_Model),main="Normal Probability Plot of residuals ")
plot(Fires_Model,2)

# Independence Assumption: No violation of Indpendence is shown as the points show no pattern
plot(residuals(Fires_Model), main = "Residuals vs Index", xlab = "Index" , ylab = "Residuals"); abline(h=0, col = "red", lty=4)

# Correlation Test
cor.test(Damage, Distance)

# ScatterPlot
ggplot(Fire, aes(Distance,Damage)) +geom_point(color= "mediumpurple1") +  
  geom_smooth(method = "lm", se = FALSE, color = "forestgreen") +
  xlab("Distance (in miles)") +  ylab("Damage (in thousands of dollars)") + ggtitle("Correlation of Distance & Damage") +
  theme(plot.title = element_text(face="bold", size=(17), color = "black"))   + 
  theme(plot.title = element_text(hjust = 0.5))

scatterplot(Distance~Damage, boxplots= FALSE, smooth=FALSE)









#Study 2
View(Salaries)
head(Salaries);dim(Salaries); summary(Salaries)

# Converting the Qualitative Variables 
Salaries$X3<- factor(Salaries$X3)
Salaries$X6 <- factor(Salaries$X6)
Salaries$X9 <- factor(Salaries$X9)

Salaries_Model1<- lm(Y~., data=Salaries[,-1])

summary(Salaries_Model1)

#Backward Selection to choose the most optimal model
Salaries.backward<-step(Salaries_Model1,direction = "backward")
summary(Salaries.backward)


#Forward Selection to choose the most optimal model
Salaries_Model2 <- lm(Y ~ 1, data=Salaries[,-1])
summary(Salaries_Model2)
Salaries.forward<- step(Salaries_Model2, scope= formula(Salaries_Model1), direction = "forward")
summary(Salaries.forward)

# Forward Stepwise Selection
Salaries.Step<- step(Salaries_Model2, scope= formula(Salaries_Model1))
summary(Salaries.Step)

#Collinearity check
vif(Salaries.backward)
cor(Salaries[,c (3,4,6,7)]) # Exclides X3 as its a Qualitative variable 

#Plots
plot(Salaries.backward,1) # Linearity Assumption & Equal Variance Assumption
plot(Salaries.backward,2) #Normality Assumption
plot(Salaries.backward$residuals) # Independence Assumption


