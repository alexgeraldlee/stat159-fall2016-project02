scripts = code/scripts
parts = report/sections
reports = report/sections
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

#regressions - 5 types (OLS, lasso, ridge, pcr, pslr)
regression:
	make ols
	make ridge
	make lasso
	make pcr
	make pslr

ols:
	cd $(scripts) && Rscript regressions.R

ridge:
	cd $(scripts) && Rscript ridge.R

lasso:
	cd $(scripts) && Rscript lasso.R

pcr:
	cd $(scripts) && Rscript pcr.R

pslr:
	cd $(scripts) && Rscript pslr.R


#report - generate the report from the components
report: $(mds)
	pandoc -s $(mds) -o report/report.Rmd
	make report/report.pdf

report/report.pdf:
	cd report && Rscript -e "library('knitr'); library('rmarkdown'); render('report.Rmd', 'pdf_document')"

#remove the final report
clean:
	rm report/report.pdf