# Rough Plan 

## Part 1: Income inequality - Data manipulation and exploration

### Q1)
  - upload into excel into stata format
  - get rid of first row
  - export to excel and then reimport
  - save as .dta

### Q2)
  - rename all variables so that they are in lower case
  - destring all relevant variables
  - 


********START HERE********
clear
set more off
capture log close
set type double

global path "C:\Users\raymo\OneDrive\Desktop\SCHOOL\2025 Winter Semester\ECON 2708\ASSIGNMENT\ASSIGNMENT 3\Data"
global output "$path/Output"
global input "$path/Input"

log using "$path/Logs/assignment3_LOG", text replace




******************************
*CLEANING FOR consumption.csv*
******************************



clear

import excel "$path/Temp/GCIPrawdata.xlsx", sheet("GCIPrawdata") cellrange(A3) firstrow clear
save "$input/GCIPrawdata.dta", replace
use "$input/GCIPrawdata", clear



******************************
*Question 2. Prepare the data*
******************************
*part a*
rename *, lower
rename decile*income decile*

*part b*
drop if year < 1980 | year > 2014
keep if inlist(country, "Canada", "China")

*part c*
reshape long decile, i(country year) j(decileindex)
rename decile income
rename decileindex decile

*part d* 
bysort country year: egen TotalIncomeForTheYear = sum(income)
gen share_income_percent = income / TotalIncomeForTheYear*100

*part e*
bysort country year: gen cumulative_share_percent = sum(share_income_percent)

gen perfect_equality = cumulative_share_percent  // for the 45-degree equality line

gen cumulative_population_percent = decile*10


preserve
keep if (country == "Canada" & (year == 1980 | year == 2014)) | (country == "China" & (year == 1980 | year == 2014))

twoway (line cumulative_share_percent cumulative_population_percent, sort lcolor(blue)) ///
       (line perfect_equality cumulative_share_percent, sort /*lpattern(dash)*/lcolor(red)) ///
       , by(country year, title("Lorenz Curve by Country-Year")) ///
       xlabel(0(10)100) ylabel(0(10)100) ///
       xtitle("Cumulative Share of Population (%)") ///
       ytitle("Cumulative Share of Income (%)") ///
       legend(order(1 "Lorenz Curve" 2 "Perfect Equality Line"))

restore  // Brings back the full dataset after plotting
	   
graph export "$output/LORENZ_CURVE.pdf", replace

