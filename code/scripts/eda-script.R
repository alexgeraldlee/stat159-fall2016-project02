
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

