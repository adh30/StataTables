// stata_ba_table
********************************
// [stata_ba_table.do]
// Author: ADH	
// Date: 08/07/22
// Description: 'Table of results for Bland Altman analysis using concord' 
// using multiple variables for comparison
// version 1.0
// Requirements
** user written code concord is required (Nicholas J. Cox & Thomas Steichen, 2000. "CONCORD: Stata module for concordance correlation," Statistical Software Components S404501, Boston College Department of Economics, revised 09 Aug 2007) http://www.stata-journal.com/software/sj10-4
********************************
// standard settings
version 17
//clear all
//macro drop _all
//set linesize 80
//set more off
//pause on
********************************
// modify the next line to use your dataset rather than the example dataset. 
// This is only included for the purpose of the example.
import delimited "https://raw.githubusercontent.com/Lifelong-Health-Ageing/Stata-Tables/4fe4feba092e6b63db6ea206cf01430defeadf3b/data/Bland_pefr.csv?token=GHSAT0AAAAAABWNIXGJMQC7VODF4JDPMOICYWINVIQ", clear

********************************
// set up locals
local varlist w_pefr mw_pefr // we omit the number of the observation so we can include that in the loop
local labellist `" "Wright Flow meter PEFR" "Mini-Wright Flow meter PEFR" "'
local collist `" "Variable" "Mean difference" "Lower limit of agreement" "Upper limit of agreement" "Lin's CCC" "'
local totalrows = 3			// this should be the number of variables + 1 (for the title)
local totalcolumns = 5		// this should be the number of column labels
local row = 1  				// start values
local col =1
local j = 1					//the number of the first observation (e.g. w_pefr1)
local k = 2					//the number of the second observation (e.g. w_pefr2)
*********************************
// start putdocx
putdocx clear
putdocx begin
putdocx paragraph
putdocx text ("Table 2. Reproducibility of measures"), bold
putdocx table tbl2 = (`totalrows', `totalcolumns')
*********************************
// Label variables in rows
foreach rlbl of local labellist {
		//local row = `row'+1
		local ++row								// increments row
		putdocx table tbl2(`row',1) = ("`rlbl'")
}

// Label columns
foreach clbl of local collist {
		putdocx table tbl2(1,`col') = ("`clbl'")
		local ++col
}
**********************************
// do loop for concord
local row = 1	// reset row 
foreach x of local varlist {
		local ++row		
		concord `x'`j' `x'`k'
			local col=1
			local results `r(diff)' `r(LOA_ll)' `r(LOA_ul)' `r(rho_c)'
			foreach cell of local results {
				local ++col
				//disp `cell'
				putdocx table tbl2(`row',`col') = (`cell')
			}
}
*********************************
// Prettify the table
// format the decimal places
putdocx table tbl2(.,2/4), nformat(%10.1f)
putdocx table tbl2(.,5), nformat(%10.2f)
*********************************
// save putdocx
putdocx save ba_table.docx, replace
