# StataTables
#### Project Status: In progress

## Project Description
Stata code to create customizable tables using the collect and/or tables command and write them into a word document (docx). This repo started out as an exercise in using the collect and tables commands in Stata 17 but I have shared it in case it is useful to anyone wanting to make tables in word using a do file.

## How does it work?
* stata_1col_table1 makes a simple 1-column 'Classic Table 1' of sample characteristics
* stata_2col_table1.do does the same for a 2-column table of sample characteristics (e.g. men and women). This has not been extensively tested as I worked on the (more difficult) 3 column version first. I haven't implemented non-parametric statistics for this file but this could be done fairly simply based on code in the stata_3col_table1.do (see below)
* stata_3col_table1.do creates a 'Classic Table 1' but with 3 groups not 2. This makes the coding a bit more complex as you can't use t-tests in table to calculate the p values. Instead it uses one-way ANOVA as an omnibus test for parametric data, Kruskal Wallis for skewed data and Chi2 for categorical data. I've solved how to include p values from a Kruskal Wallis ANOVA but it feels clunky and there may be a better way. I've also added some post-hoc tests (unadjusted for multiple comparisons). **This do file requires that conovertest.ado by Alexis Dinno (https://alexisdinno.com/stata) is installed. This performs a Conover-Iman test of multiple comparisons using rank sums**
* stata_corr_table.do creates a correlation matrix. 
* stata_table_reg1.do creates a regression table. This is in development and is quite rudimentary at present. There is no putdocx implemented yet.
* stata_table_regmodels.do creates a table that compares multiple adjusted models also in development. There is no putdocx implemented yet.
* stata_ba_table.do creates a table of results for a Bland Altman analysis. **This do file requires the concord.ado package by Thomas J. Steichen, RJRT & Nicholas J. Cox, Durham University (http://www.stata-journal.com/software/sj10-4)**

Some of this code is based on code written by Chuck Huber https://www.timberlake.co.uk/news/customizable-tables-in-stata-17-with-chuck-huber/. The Stata manuals are also a useful source of code.

## Data sources
In most cases the code uses a freely available set of the [Second National Health and Nutrition Examination Survey](https://www.stata-press.com/data/r17/nhanes2l) as an example. 
Additional public data for testing purposes (sample PEFR data set from Bland, J. M., & Altman, D. (1986). Statistical methods for assessing agreement between two methods of clinical measurement. The Lancet, 327(8476), 307-310. PMID:2868172. http://dx.doi.org/10.1016/S0140-6736(86)90837-8) are available in the /data subdirectory. 

## Requirements (Software or packages that needs to be installed and and how to install them).
* Stata 17.0 (may work with other versions but not tested)
* Microsoft Word 365 (may work with other versions but not tested)
* Some do files may require additional Stata packages (see description of specific do file)

## Getting started
Just modify the do file to use a dataset of your choice and add the relevant variables to the locals for continuous and categorical variables. 

## Useful references
https://www.stata.com/manuals/tables.pdf
https://www.stata.com/new-in-stata/tables/

## Authors
* Alun Hughes (Twitter: @alundhughes30; Github: https://github.com/adh30)

## License
This project is licensed under the GNU General Public License v3.0 (https://github.com/adh30/BPplus-Reservoir/blob/Version-1-beta-4/LICENSE)).

## Acknowledgments
* Chuck Huber Customizable tables in Stata 17, (parts 1 to 7) on http://blog.stata.com/
* https://rdrr.io/cran/BlandAltmanLeh/man/bland.altman.PEFR.html 
