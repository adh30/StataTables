use https://www.stata-press.com/data/r17/nhanes2l

// clear any previous collect
collect clear
local exposures age weight i.race i.sex
collect _r_b _r_ci _r_p: regress bpsystol `exposures'
collect title "Table: Regression Results"
collect layout (colname) (result)
collect style showbase off
collect style cell result[_r_ci], sformat("(%s)") cidelimiter(", ") nformat(%9.2f)
collect style cell result[_r_b], halign(center) nformat(%9.2f) 
collect style cell result[_r_p], minimum(0.001) maximum(0.999) nformat(%5.3f)
collect style cell, border(right, pattern(nil))
// create a local variable to allow formatting of r2
local r2 = `e(r2)'
local r2 : di %5.3f `r2'

collect notes `"N = `e(N)'; R2 = `r2'"'
collect preview
