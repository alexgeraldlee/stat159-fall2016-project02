scripts = code/scripts
mds = $(wildcard report/sections/*.Rmd)

all: eda regression report




#download the Credit data and dummify its categorical variables
data: data/raw-credit.csv data/Credit.csv

data/raw-credit.csv:
	curl http://www-bcf.usc.edu/~gareth/ISL/Credit.csv -o data/raw-credit.csv

data/Credit.csv:
	cd $(scripts) && Rscript data-processing.R


#exploratory data analysis
eda: data/eda-output.txt

data/eda-output.txt:
	cd $(scripts) && Rscript eda-script.R

#regressions - 5 types (OLS, lasso, ridge, pcr, plsr)
regression:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

ols:
	cd $(scripts) && Rscript regressions.R

ridge:
	cd $(scripts) && Rscript ridge.R

lasso:
	cd $(scripts) && Rscript lasso.R

pcr:
	cd $(scripts) && Rscript pcr.R

plsr:
	cd $(scripts) && Rscript plsr.R


#report - generate the report from the components
report: 
	make report/report.Rmd

report/report.Rmd:
	pandoc -s $(mds) -o report/report.Rmd
	make report/report.pdf

report/report.pdf: report/report.Rmd
	cd report && Rscript -e "library('knitr'); library('rmarkdown'); render('report.Rmd', 'pdf_document')"

#remove the final report
clean:
	rm report/report.pdf