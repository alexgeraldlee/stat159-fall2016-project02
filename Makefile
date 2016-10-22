

all: credit-data




#download the Credit data and dummify its categorical variables
credit-data: data/raw-credit.csv data/Credit.csv

data/raw-credit.csv:
	curl http://www-bcf.usc.edu/~gareth/ISL/Credit.csv -o data/raw-credit.csv

data/Credit.csv:
	cd code/scripts && Rscript data-processing.R


#remove the final report
clean:
	rm report/report.pdf