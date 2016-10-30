

all: eda regression report




#download the Credit data and dummify its categorical variables
credit-data: data/raw-credit.csv data/Credit.csv

data/raw-credit.csv:
	curl http://www-bcf.usc.edu/~gareth/ISL/Credit.csv -o data/raw-credit.csv

data/Credit.csv:
	cd code/scripts && Rscript data-processing.R


#exploratory data analysis
eda: data/eda-output.txt

data/eda-output.txt:
	cd code/scripts && Rscript eda-script.R

#regressions - 5 types (OLS, lasso, ridge, pcr, pslr)
regression: 



#remove the final report
clean:
	rm report/report.pdf