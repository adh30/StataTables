/* dtable1.do
Table 1. using dtable and some simple reformatting edits
ADH version 1.0
31/12/2024
*/
sysuse auto, clear
// Table 1
dtable   mpg weight length price /// we'll do price as median [IQR] the others as mean (sd)
1.foreign i.rep78, /// illustrates one factor and all factors
continuous(, statistic(count mean sd)) ///
continuous(price, statistics(count median iqr)) sformat("[%s]" iqr) ///
nformat(%8.1f mean median sd iqr) ///
nformat(%15.0fc count) ///
title(Table 1.) ///
note(Abbreviations: iqr, interquartile range; sd, standard deviation; )

collect levels result
/* Collection: DTable
 Dimension: result
    Levels: _dtable_stats _dtable_test frequency fvfrequency fvpercent iqr mean median
            percent proportion rawpercent rawproportion sd sumw
*/
* define custom composite results to split the statistics into 3 columns
collect composite define col1 = count fvfrequency
collect composite define col2 = mean median fvpercent
collect composite define col3 = sd iqr
// median iqr
collect label levels result ///
	col1 "N" ///
	col2 "mean/median/(%)" ///
	col3 "(sd)/[IQR]" ///
	, modify
* replace the result autolevels with custom columns
collect style autolevels result col1 col2 col3 _dtable_test, clear
* preview
collect preview

// publish into word docx
// collect export [path filename], replace