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

// create table 
table () sex, statistic(mean `ncontvar') statistic(sd `ncontvar') statistic(median `skcontvar') statistic(iqr `skcontvar') statistic(fvfrequency `catvar') statistic(fvpercent `catvar') nformat(%9.1f mean sd) nototal

// Calculates the relevant p values for various categories
// t-test
foreach x in `ncontvar' {
	quietly: collect r(p), tag(var[`x']): ttest `x', by(sex)
}
//ranksum
foreach x in `skcontvar' {
	quietly: collect r(p), tag(var[`x']): ranksum `x', by(sex)
}
// chi2 
foreach x in `catvar' {
	//TBA
}

// 1-D table 1
// recode the frequency to the same columns as mean sd p
collect recode result fvfrequency=mean fvpercent=sd median=mean iqr=sd
//collect recode p1=result[p]
// rename labels for mean and sd
collect label levels result mean "Mean/Median/N" sd "(SD)/[IQR]/%", modify
//collect layout (var) (sex#result)
// drop right border
collect style cell, border( right, pattern(nil) )
// put SD in parenthesis in 
collect style cell result[sd], sformat("(%s)")
// Stack categories
collect	style	row	stack,	nodelimiter	nospacer	indent	length(.)	///
wrapon(word)	noabbreviate	wrap(.)	truncate(tail)
// group mean and SD together
** really want to insert the p value into Stack 
collect layout (var) (sex#result result[p])
// change format of continuous 
collect style cell result[mean]#var[`catvar'], nformat(%9.0f)
collect style cell result[sd]#var[`catvar'], sformat("%s%%") 
collect style cell result[sd]#var[`skcontvar'], sformat("[%s]")
collect style cell result[p], nformat(%9.3f)
collect preview
// send to docx
//collect export table1.docx, replace
