#Project 2: Predictive Modeling Process 
Authors: Alexander Lee & Youngshin Kim

Github html: https://github.com/alexgeraldlee/stat159-fall2016-project02


E-mails:
	alexgeraldlee@berkeley.edu
	youngshin.kim@berkeley.edu

##File Structure

```
stat159-fall2016-project2/
	README.md
	Makefile
	LICENSE
	session-info.txt
	.gitignore
	code/
		scripts/
			data-processing.R
			eda-script.R
			lasso.R
			pcr.R
			plsr.R
			regressions.R
			report-data.R
			ridge.R
	data/
		Credit.csv
		best-lasso.RData
		best-ols.RData
		best-pcr.RData
		best-plsr.RData
		best-ridge.RData
		credit-ols-coefficients.txt
		eda-output.txt
		raw-credit.csv
		test-set-data.csv
		train-set-data.csv
		...
	images/
		barchart-ethnicity.png
		barchart-gender.png
		barchart-married.png
		barchart-student.png
		boxplot-age.png
		boxplot-balance.png
		boxplot-cards.png
		boxplot-education.png
		boxplot-income.png
		boxplot-limit.png
		boxplot-rating.png
		conditional-boxplot-ethnicity.png
		conditional-boxplot-gender.png
		conditional-boxplot-married.png
		conditional-boxplot-student.png
		histogram-age.png
		histogram-balance.png
		histogram-cards.png
		histogram-education.png
		histogram-income.png
		histogram-limit.png
		histogram-rating.png
		scatterplot-matrix.png
		...
	report/
		report.pdf
		report.Rmd
		sections/
			00-abstract.Rmd
			01-introduction.Rmd
			02-data.Rmd
			03-methods.Rmd
			04-analysis.Rmd
			05-results.Rmd
			06-conclusions.Rmd
	slides/
		...
```

#Phony targets in Makefile

all: will be associated to phony targets eda, regressions, and report

data: will download the file Credit.csv to the folder data/

tests: will run the unit tests of your functions

eda: will perform the exploratory data analysis

ols: OLS regression

ridge: Rdige Regression

lasso: Lasso Regression

pcr: Principal Components Regression

plsr: Partial Least Squares Regression

regressions: all five types of regressions

report: will generate report.pdf (or report.html)

slides: will generate slides.html

session: will generate session-info.txt

clean: will delete the generated report (pdf and/or html)


#How to reproduce this project

1. Pre-modeling Data Processing (look at data-processing.R)

	-convert factors into dummy variables
	
	-mean centering and standardization

2. Training and Testing Sets 

	-Use size 300 as training set and 100 as test set

3. Model Building Process (follow R file for each model)

	-Use glmnet library for ridge/lasso

	-Use pls library for pcr/plsr



<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.



