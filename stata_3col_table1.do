********************************
// stata_3col_table1.do
// Author: Alun Hughes
// Date: 07/01/22 (version 1.1)
********************************
** NB requires that conovertest [user program] is installed [search conovertest, net]
********************************
// Description: do file to create a 'Table 1' but with 3 categories and write to a word file
// The use of subgroup comparisons after an omnibus test is frequently criticised 
// although often requested by reviewers. The post hoc tests (unadjusted) are added 
// here but you dont have to use them!

********************************
* Useful commands when modifying this file 
********************************
// use return list to see what is stored as results
// use ereturn list to see what is stored as extended results
// use matrix list r(table) to see what is stored as results matrix
********************************
version 17	// set version
clear		// clear any existing data
// no log file since we are writing to word

******************************** 
* Open Dataset 
********************************
webuse nhanes2 // as an example

********************************
* Clear any previous collect
********************************
collect clear

***************************
* Data selection (assumes that you have looked at data distributions)
***************************
// create local macro for normally distributed continuous variables
local ncontvar age height bpsystol
// create local macro for normally distributed continuous variables
local skcontvar tgresult hdresult
// create local macro for categories [currently only designed for binary categories]
local catvar sex diabetes

**************************
* Create table 
**************************
table () race, statistic(count `ncontvar') statistic(mean `ncontvar') statistic(sd `ncontvar') statistic(count `skcontvar') statistic(median `skcontvar') statistic(iqr `skcontvar') statistic(fvfrequency `catvar') statistic(fvpercent `catvar') nformat(%9.1f mean sd) nototal name(Table1)

***************************
* calculate omnibus p values and comparisons with group 1
***************************
// ANOVA for normally distributed variables
// Calculates the relevant p values for various categories
foreach x in `ncontvar' {
	quietly anova `x' i.race
	quietly: collect, tag(var[`x']): contrast race
}

// Kruskal Wallis ANOVA for skewed variables
foreach x in `skcontvar' {
	quietly  kwallis `x', by (race)
	// kwallis doesnt store a value for p so we have to calculate one!
	local pval=chi2tail(r(df), r(chi2_adj))
	// and capture it using echo (it appears as value)
	quietly: collect, tag(var[`x']):  echo `pval'
	quietly: collect, tag(var[`x']): conovertest `x', by(race) 
	//quietly: collect r(p), tag(var[`x']): conovertest `x', by(race) 
}

// Chi2 test for categories
// note that collecting into 1.`x' allows the p value to displayed in 1.var which is useful for the table display
// chi2 (r(p) p-value for Pearson's chi-squared test; r(p_exact) Fisher's exact p; 
// r(p_lr) p-value for likelihood-ratio test)
foreach x in `catvar' {
	quietly: collect, tag(var[1.`x']): mlogit `x' i.race
}

***************************
* Recode,  relabel and style Table
***************************
// recode the frequency to count, percent to mean, IQR to sd, value (p for KW) to p, P(conover) to _r_p
collect recode result fvfrequency=count fvpercent=mean median=mean iqr=sd value=p P =_r_p
collect recode colname c1 = 2.race c2 = 3.race
// rename labels for count, mean, median,  sd and P
collect label levels result count "N" mean "Mean/median/%" sd "(SD)/[IQR]" p "Omnibus p-value", modify
collect label levels colname race "White vs", modify
// drop right border
collect style cell, border( right, pattern(nil) )
// Stack categories
collect	style row	stack,	nodelimiter	nospacer	indent	length(.)	///
wrapon(word)	noabbreviate	wrap(.)	truncate(tail)
// change format of mean and dispersion measures 
collect style cell result[mean]#var[`catvar'], nformat(%9.0f)
collect style cell result[mean]#var[`catvar'], sformat("%s%%") 
collect style cell result[sd]#var[`ncontvar'], sformat("(%s)")
collect style cell result[sd]#var[`skcontvar'], sformat("[%s]")
collect style cell result[p], nformat(%9.3f)

// Table consists of two columns - race by result and p values
//collect layout (var) (race#result result[p] colname[2.race]#result[_r_p] colname[3.race]#result[_r_p]) (), name(Table)

// collect layout (var) (race#result result[p] colname[2.race]#result[_r_p] colname[3.race]#result[_r_p] result[P]#colname[c1 c2]) (), name(Table) // this works but ideally columns need recoding - havent worked out how to do that correctly!
collect layout (var) (race#result result[p] colname[2.race]#result[_r_p] colname[3.race]#result[_r_p])  (), name(Table1)

// Column labels [this can be incorporated into the collect labels above in due course]
//collect label levels colname race "White vs", modify
//collect preview // for checking during debugging

****************************
* Send to docx
****************************
putdocx clear
putdocx begin, font(Arial, 9) landscape // assumes landscape needed - it generally is for 3 columns use font 9 to fit can easily be edited later.
putdocx paragraph
putdocx text ("Table 1. "), bold  // add table legend here if you want
putdocx collect
putdocx paragraph
putdocx text ("Table footnotes to be added")
putdocx save "C:\data\table1.docx", replace  // send to docx currently in C:\data assuming this exists in most stata installations
