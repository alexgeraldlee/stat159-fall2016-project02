
#importing the raw credit because we don't need cleaned data
#to perform exploratory analysis (summary statistics, etc.)
credit <- read.csv('../../data/raw-credit.csv')

#qualitative variables: Gender, Student, Married, Ethnicity
#quantitative variables: Income, Limit, Rating, Cards, Age, Education, Balance

credit_quant <- credit[,c("Income", "Limit", "Rating",
                          "Cards", "Age", "Education", "Balance")]

credit_qual <- credit[,c("Gender", "Student", "Married", "Ethnicity")]

output_file <- "../../data/eda-output.txt"

cat("Summary Statistics for Quantitative Variables\n", 
    file = output_file)

quant_sd <- 0
quant_range <- 0
quant_iqr <- 0
for(i in 1:ncol(credit_quant)){
  quant_sd[i] <- sd(credit_quant[,i])
  ranges <- range(credit_quant[,i])
  quant_range[i] <- ranges[2] - ranges[1]
  quant_iqr[i] <- IQR(credit_quant[,i])
}
names(quant_sd) <- names(credit_quant)
names(quant_range) <- names(credit_quant)
names(quant_iqr) <- names(credit_quant)
sink(output_file, append = T)
summary(credit_quant)
cat("\nStandard Deviations\n")
quant_sd
cat("\nRanges\n")
quant_range
cat("\nInterquartile Ranges\n")
quant_iqr
sink()

#histograms and boxplots
png('../../images/histogram-income.png')
hist(credit_quant$Income, main = "Histogram of Income", 
     xlab = "Income")
dev.off()

png('../../images/histogram-limit.png')
hist(credit_quant$Limit, main = "Histogram of Limit", 
     xlab = "Limit")
dev.off()

png('../../images/histogram-rating.png')
hist(credit_quant$Rating, main = "Histogram of Rating", 
     xlab = "Rating")
dev.off()

png('../../images/histogram-cards.png')
hist(credit_quant$Cards, main = "Histogram of Number of Cards", 
     xlab = "Number of Cards")
dev.off()

png('../../images/histogram-age.png')
hist(credit_quant$Age, main = "Histogram of Age", 
     xlab = "Age")
dev.off()

png('../../images/histogram-education.png')
hist(credit_quant$Education, main = "Histogram of Education Level", 
     xlab = "Years of Education")
dev.off()

png('../../images/histogram-balance.png')
hist(credit_quant$Balance, main = "Histogram of Balance", 
     xlab = "Balance")
dev.off()

png('../../images/boxplot-income.png')
boxplot(credit_quant$Income, main = "Boxplot of Income", 
     xlab = "Income", horizontal = T)
dev.off()

png('../../images/boxplot-limit.png')
boxplot(credit_quant$Limit, main = "Boxplot of Limit", 
        xlab = "Limit", horizontal = T)
dev.off()

png('../../images/boxplot-rating.png')
boxplot(credit_quant$Rating, main = "Boxplot of Rating", 
        xlab = "Rating", horizontal = T)
dev.off()

png('../../images/boxplot-cards.png')
boxplot(credit_quant$Cards, main = "Boxplot of Cards", 
        xlab = "Cards", horizontal = T)
dev.off()

png('../../images/boxplot-age.png')
boxplot(credit_quant$Age, main = "Boxplot of Age", 
        xlab = "Age", horizontal = T)
dev.off()

png('../../images/boxplot-education.png')
boxplot(credit_quant$Education, main = "Boxplot of Education", 
        xlab = "Education", horizontal = T)
dev.off()

png('../../images/boxplot-balance.png')
boxplot(credit_quant$Balance, main = "Boxplot of Balance", 
        xlab = "Balance", horizontal = T)
dev.off()

#summary statistics for qualitative variables
#tables of frequency and relative frequency


sink(output_file, append = T)
cat("\nDescriptive Statistics of Qualitative Variables\n\nGender\n")
data.frame(Frequency = summary(credit_qual$Gender), 
           Proportion = summary(credit_qual$Gender) / length(credit_qual$Gender))
cat("\nStudent\n")
data.frame(Frequency = summary(credit_qual$Student), 
           Proportion = summary(credit_qual$Student) / length(credit_qual$Student))
cat("\nMarried\n")
data.frame(Frequency = summary(credit_qual$Married), 
           Proportion = summary(credit_qual$Married) / length(credit_qual$Married))
cat("\nEthnicity\n")
data.frame(Frequency = summary(credit_qual$Ethnicity), 
           Proportion = summary(credit_qual$Ethnicity) / length(credit_qual$Ethnicity))
sink()

#barcharts of the frequencies

png('../../images/barchart-gender.png')
plot(credit_qual$Gender, main = "Barchart of Gender", 
     xlab = "Gender", ylab = "Frequency")
dev.off()

png('../../images/barchart-student.png')
plot(credit_qual$Student, main = "Barchart of Student", 
     xlab = "Student", ylab = "Frequency")
dev.off()

png('../../images/barchart-married.png')
plot(credit_qual$Married, main = "Barchart of Married", 
     xlab = "Married", ylab = "Frequency")
dev.off()

png('../../images/barchart-ethnicity.png')
plot(credit_qual$Ethnicity, main = "Barchart of Ethnicity", 
     xlab = "Ethnicity", ylab = "Frequency")
dev.off()

#matrix of correlations for quantitative variables
quant_corr <- round(cor(credit_quant), 4)
sink(output_file, append = T)
cat("\n\nCorrelation Matrix for Quantitative Variables\n")
quant_corr
sink()

#scatterplot matrix of quantitative variables
png('../../images/scatterplot-matrix.png')
plot(credit_quant)
dev.off()

