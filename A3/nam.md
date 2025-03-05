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
	import excel "$input/GCIPrawdata.xlsx", sheet("GCIPrawdata") clear
	drop if A == "Source: Global Consumption and Income Project. All incomes expressed in 2005 USD PPP."

	export excel using "$input/GCIPrawdata_row_removed", replace
	import excel "$input/GCIPrawdata_row_removed.xlsx", firstrow clear
	save "$input/GCIPrawdata.dta", replace

** Question 2**
	rename *, lower
	ds country, not
	destring `r(varlist)', replace 
	keep if year == 1980 | year == 2014
	keep if country == "China" | country == "Canada"
	drop meanincome population
log close

