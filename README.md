# trips

Given a properly formated .txt document containing `drivers` and `trips`, this program attempts to generate a report called `out.txt` that contains a summary of all the drivers and their trips.


**Note:** This program assumes that each input file will be in the proper format like below, where where each driver/trip is seperated by newlines:

**Driver**

`Driver ${name}`

and 

**Trip**

`Trip ${name} ${HH:MM} ${HH:MM} ${miles as a number}`


## To run ##
1. First, get into the directory `cd\trips` 
2. Then, on the command line run `ruby trips.rb in.txt` (or replace in.txt with any other properly formated input file)
