# Stata-Tables
#### Project Status: In progress

## Project Description
Code to create customizable tables in Stata using the collect and/or tables command. This repo started out as an exercise in using the collect and tables commands in Stata 17 but I have shared it in case it is useful to anyone wanting to make tables in word using a do file.

## How does it work?
* stata_1col_table1 makes a simple 1 column 'Classic Table 1' of characteristics
* stata_2col_table1.do does the same for a 2 column table. This has not been extensively testsed as I worked on the (more difficult) 3 column version first. 
* stata_3col_table1.do creates a 'Classic Table 1' but with 3 groups not 2. This makes the coding a bit more complex as you can't use t-tests in table to calculate the p values so it uses one-way ANOVA as an omnibus test for parametric data, Kruskal Wallis for skewed data and Chi2 for categorical data. I've also solved how to include p values from a Kruskal Wallis ANOVA but it feels clunky and there may be a better way. I've also added some post-hoc tests (unadjusted for multiple comparisons). **This do file requires that conovertest.ado by Alexis Dinno (https://alexisdinno.com/stata) is installed. This performs a Conover-Iman test of multiple comparisons using rank sums**
* stata_table_reg1.do creates a regression table
* stata_ba_table.do creates a table of results for a Bland Altman analysis. **This do file requires the concord.ado package by Thomas J. Steichen, RJRT & Nicholas J. Cox, Durham University (http://www.stata-journal.com/software/sj10-4)**

Some of this code is based on code written by Chuck Huber https://www.timberlake.co.uk/news/customizable-tables-in-stata-17-with-chuck-huber/. 

## Data sources
The code uses a freely available set of the [Second National Health and Nutrition Examination Survey](https://www.stata-press.com/data/r17/nhanes2l) as an example. 
Additional public data for testing purposes are available in the /data subdirectory.

## Requirements (Software or packages that needs to be installed and and how to install them).
* Stata 17.0 (may work with other versions but not tested)
* Microsoft Word 365 (may work with other versions but not tested)
* Some do files may require additional Stata packages (see specific do file)

## Getting started
Just modify the do file to use a dataset of your choice and add the relevant variables to the locals for continuous and categorical variables. 
At present I havent included the code for skewed variables except in stata_3col_table1.do but since this is the most complex example it should be quite straighforward to implement.  

## Useful references
https://www.stata.com/manuals/tables.pdf
https://www.stata.com/new-in-stata/tables/

## Authors
* Alun Hughes (Twitter: @alundhughes30; Github: https://github.com/adh30)

## License
This project is licensed under the GNU General Public License v3.0 (https://github.com/adh30/BPplus-Reservoir/blob/Version-1-beta-4/LICENSE)).

## Acknowledgments
* Chuck Huber Customizable tables in Stata 17, (parts 1 to 7) on http://blog.stata.com/
