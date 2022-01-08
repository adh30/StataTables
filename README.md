# Stata_collect_tables
Code to create customizable tables in stata using the collect or tables command.

This is work in progress so I will update as I learn more. 

This code is based on code written by Chuck Huber https://www.timberlake.co.uk/news/customizable-tables-in-stata-17-with-chuck-huber/. 

stata_3col_table1.do creates a 'classic table 1' but with 3 groups not 2. This makes the coding a bit more complex as you can't use t-tests in table to calculate the p values so it uses one-way ANOVA as an omnibus test for parametric data, Kruskal Wallis for skewed data and Chi2 for categorical data. (Kutner MH, Nachtsheim CJ, Neter J, Li W. Applied Linear Models, 5th ed. New York: McGraw-Hill/Irwin; 2005) I've also solved how to include p values from a Kruskal Wallis ANOVA but it feels clunky and there may be a better way. I've also added some post-hoc tests (unadjusted for multiple comparisons). 

stata_2col_table1.do does the same for a 2 column table. This is incomplete as I worked on the harder version first. 

stata_table_reg1.do creates a regression table - not much modified from Huber's original

stata_table_reg2.do will create regression coefficient tables for a single exposure with multiple models. 
