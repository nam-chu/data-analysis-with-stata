# Tutorial 5 / Lecture Practice

## Question 1

### a) What is the unit of observation in this dataset?
- you can use `codebook` to determine whether or not there are the same number of observations are there are observation
- you can also use `sort block month`
- further can be refined with `duplicates report block month`

### b) Rename variables so that they all have names in English.
- barrio = neighbourhood
- calle = street
- altura = height

### c) Make a list of all the dummy/indicator variables (those that take values of 0 or 1 only). Use any command in Stata that you may find useful to guarantee that these are dummy variables.
- first `summarize`, then based on these you can `tabulate varlist`.
- You can use a loop for this ie `for var in varlist ... {
  tab 'var' }`

### d) What is the treatment and the control group in this study? What is the dummy variable that identifies the treatment group? What is the dummy that identifies the before/after observations? What is our outcome variable?

- outcome: `thefts`
- treatment: `sameblock`
- before: `Before July`
- after: `After July`

### e) Are there any variables that you could use as additional control variables for the difference-in-differences (DID) analysis?
- control variables: potentially bank would affect car thefts since there are cameras, also gas stations there are a lot cars to potentially steal, public building also because there are more people traffic and maybe more cars to be stolen 

## Question 2
### Part a)
- generate a dummy variable using `gen var = ()`
- 




