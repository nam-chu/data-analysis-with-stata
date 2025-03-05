/*
Assignment 2: By Hoang-Nam Chu and Raymond Van

*/

// This is our classic preample that we always use at the start of our do files.
clear 
set more off
set type double
capture log close


// Here we are setting our global variables as macros
global path  "/Users/home_folder/ECON 2708/Deliverables/Assignments/2708_A3/Data"
global output  "$path/Output"
global input  "$path/Input"

log using "$path/Logs/assignment_3", text replace


** Question 1 **

	clear

	import excel "$path/Input/GCIPrawdata.xlsx", sheet("GCIPrawdata") cellrange(A3) firstrow clear
	save "$input/GCIPrawdata.dta", replace
	use "$input/GCIPrawdata", clear


** Question 2**

** Part a
	rename *, lower
	rename decile*income decile*
	keep if year == 1980 | year == 2014
	keep if inlist(country, "Canada", "China")
	reshape long decile, i(country year) j(decileindex)
	rename (decile decileindex) (income decile)
	bysort country year: egen annualincome = sum(income)
	gen share_income_percent = income / annualincome*100
	
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


**** Part 2
****** Question 1

	use "$input/CK1994 (1).dta", clear
	
	gen mealprice = pricefry + pricesoda + priceentree
	
	gen stateXtime = state*time 
	
	reg mealprice state time stateXtime
	log close


****** Question 2 

	** part a)
	use "$input/DS2004.dta", clear

	gen after = (month > 7)
	tabulate oneblock after, sum(thefts) nost nofreq

	** part b)
	
	drop if month == 7
	gen sameblockXafter = sameblock * after
	gen oneblockXafter = oneblock * after
	reg thefts sameblock oneblock after sameblockXafter oneblockXafter, robust
