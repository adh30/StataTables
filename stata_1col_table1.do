// stata_1coltable1
********************************
// [stata_1coltable1.do]
// Author: ADH	
// Date: 08/11/21
// Description: 'Classic Table 1'
********************************
// standard settings
version 17
//clear all
//macro drop _all
//set linesize 80
//set more off
//pause on
********************************
// modify to use dataset.
use https://www.stata-press.com/data/r17/nhanes2l

// create table 1 of characteristics
// clear any previous collect
collect clear
// local macro for normally distributed continuous variables (modify for other datasets)
local ncontvar age height weight bpsystol bpdiast tcresult
// local macro for categroical variables
local catvar sex race

table (),  statistic(mean `ncontvar') statistic(sd `ncontvar') statistic(fvfrequency `catvar') statistic(fvpercent `catvar') nformat(%10.1f mean sd) nototal

// recode the frequency to the same columns as mean sd 
collect recode result fvfrequency=mean fvpercent=sd 

collect label levels result mean "Mean/N" sd "(SD)/%", modify

// drop right border
collect style cell, border( right, pattern(nil))

// put SD in parenthesis
collect style cell result[sd], sformat("(%s)")

// Stack categories
collect	style	row	stack,	nodelimiter	nospacer indent	length(.) wrapon(word)	noabbreviate	wrap(.)	truncate(tail)

// create two columns
collect layout (var) (result)
// format categories
collect style cell result[mean]#var[`catvar'], nformat(%9.0f)
collect style cell result[sd]#var[`catvar'], sformat("%s%%") 

// start putdocx
putdocx clear
putdocx begin
putdocx paragraph
putdocx text ("Table 1. Sample characteristics"), bold
putdocx collect
// save putdocx - I have commented this out for now.
// putdocx save tables.docx, replace 
