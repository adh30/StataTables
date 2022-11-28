// Correlation table
cd C:\data // can be changed freely but most installations have c:\data
collect clear // clear all collections
sysuse auto
pwcorr, sig
matrix define vech = vech(r(C)) //make a column vector formed by listing the lower triangle elements of r(C)
collect create corrtab // make new collection called corrtab
collect get corr=vech(r(C)) sig=vech(r(sig)) // get r and p
collect layout (rowname#result) (roweq)
collect style cell, nformat(%9.3g)
collect style cell result[corr], maximum(0.99, label(".")) nformat(%6.3f) halign(center)
collect style cell result[sig], minimum(0.001) nformat(%6.3f) halign(center)
collect style cell result[sig], maximum(0.99) nformat(%6.3f) halign(center)
collect style header result, level(hide)
collect style cell border_block[corner row-header], border(right, pattern(nil))
// collect preview
// cd to relevant folder

//Excel
collect export corrtab.xlsx, name(corrtab) sheet(Table1) replace
//Word
collect export corrtab.docx, replace
