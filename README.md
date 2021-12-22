# Stata_collect_tables
Code to create customizable tables in stata using the collect or tables command.

This is work in progress so I will update as I learn more. 

This code is based on code written by Chuck Huber https://www.timberlake.co.uk/news/customizable-tables-in-stata-17-with-chuck-huber/. 

stata_3col_table1.do creates a 'classic table 1' but with 3 groups not 2. This makes the coding a bit more complex as you can't use t-tests in table to calculate the p values. I've also solved how to include p values from a Kruskal Wallis ANOVA but there may be a better way. I haven't included column by column significance tests yet.

stata_2col_table1.do does the same for a 2 column table. This is incomplete as I worked on the harder version first. 

stata_table_reg1.do is incomplete but will create regression tables with multiple models. 
