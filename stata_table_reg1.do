use https://www.stata-press.com/data/r17/nhanes2l

// clear any previous collect
collect clear
collect _r_b _r_ci _r_p: regress bpsystol age weight i.race i.sex
collect layout (colname) (result)
collect style showbase off
collect style cell, nformat(%5.2f)
collect style cell result[_r_ci], sformat("[%s]") cidelimiter(", ")
collect style cell result[_r_b], halign(center)
collect style cell result[_r_p], nformat(%5.3f)
collect style cell, border(right, pattern(nil))
collect preview
