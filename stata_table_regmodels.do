use https://www.stata-press.com/data/r17/nhanes2l

// clear any previous collect
collect clear
local model1 age i.race i.sex
local model2 `model1' weight
local model3 `model2' diabetes
forvalues i = 1/3 {
	collect _r_b _r_ci _r_p,tag(model[(`i')]): regress bpsystol `model`i''
}
collect title "Table: Regression Models"
collect layout (result[N] colname#result result[r2 r2_a F]) (model)
collect style showbase off
collect style cell result[N], halign(center) 
collect style cell result[_r_b], halign(center) nformat(%9.2f)
collect style cell result[_r_ci], sformat("(%s)") halign(center) cidelimiter(", ") nformat(%9.2f)
collect style cell result[_r_p], minimum(0.001) maximum(0.999) halign(center) nformat(%5.3f)
collect style cell result[r2], minimum(0.001) maximum(0.999) halign(center) nformat(%5.3f)
collect style cell result[r2_a], minimum(0.001) maximum(0.999) halign(center) nformat(%5.3f)
collect style cell result[F], halign(center) nformat(%9.1f)
collect style cell, border(right, pattern(nil))
collect label levels result N "N", modify
collect label levels result _r_b "beta", modify
collect style row stack, nobinder // stack levels of factor variable underneath their titles
collect style cell colname[_cons]#result[_r_p], border(bottom, pattern(single)) // put a border to seperate the R2 values
collect preview
