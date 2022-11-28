// stata_2col_table1.do
********************************
// [stata_2col_table1.do]
// Author: ADH	
// Date: 08/07/22
// Description: 'Classic Table 1 for two strata'
********************************
// standard settings
version 17
//clear all
//macro drop _all
//set linesize 80
//set more off
//pause on
********************************
use https://www.stata-press.com/data/r17/nhanes2l
// useful commands
collect dims
collect levelsof result
collect label list result
*************************
// clear any previous collect
collect clear
// create local macro for normally distributed continuous variables
local ncontvar age bpsystol bmi
// create local macro for normally distributed continuous variables
local skcontvar tgresult hdresult
// create local macro for categories 
local catvar highbp race diabetes

// create stratum - using local makes it easier to change stratifying factor
local stratum sex

// create table 
table () `stratum', statistic(mean `ncontvar') statistic(sd `ncontvar') statistic(median `skcontvar') statistic(iqr `skcontvar') statistic(fvfrequency `catvar') statistic(fvpercent `catvar') nformat(%9.1f mean sd) nototal

// Calculates the relevant p values for various categories
// t-test
foreach x in `ncontvar' {
	quietly: collect r(p), tag(var[`x']): ttest `x', by(`stratum')
}
//ranksum
foreach x in `skcontvar' {
	quietly: collect r(p), tag(var[`x']): ranksum `x', by(`stratum')
}
// chi2 
foreach x in `catvar' {
	quietly: collect r(p),  tag(var[1.`x']): tab `x' `stratum', chi2
}
// 1-D table 1
// recode the frequency to the same columns as mean sd p
collect recode result fvfrequency=mean fvpercent=sd median=mean iqr=sd
// rename labels for mean and sd
collect label levels result mean "Mean/Median/N" sd "(SD)/[IQR]/%", modify
// drop right border
collect style cell, border( right, pattern(nil) )
// put SD in parenthesis in 
collect style cell result[sd], sformat("(%s)")
// Stack categories
collect	style	row	stack,	nodelimiter	nospacer	indent	length(.)	///
wrapon(word)	noabbreviate	wrap(.)	truncate(tail)
// group mean and SD together
// insert the p value into Stack 
collect layout (var) (`stratum'#result result[p] colname[2.`stratum']#result[_r_p]) (), name(Table)
// change format of data
collect style cell result[mean]#var[`catvar'], nformat(%9.0f)
collect style cell result[sd]#var[`catvar'], sformat("%s%%") 
collect style cell result[sd]#var[`skcontvar'], sformat("[%s]")
collect style cell result[p], minimum(0.001) maximum(0.999) nformat(%9.3f))
// send to docx - 
//collect export table1.docx, replace
