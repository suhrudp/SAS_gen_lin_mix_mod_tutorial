/*IMPORT DATA*/
proc import datafile="/home/u62868661/Datasets/Generalized linear mixed-effects modelling/toenail.csv"
dbms=csv
out=df
replace;
run;

/*FREQUENCY TABLE*/
proc freq data=df;
	tables  (treatment) *(outcome) / chisq relrisk nocol nocum 
		plots(only)=(freqplot mosaicplot);
run;

/*GENERALIZED LINEAR MIXED MODEL*/
proc glimmix data=df;
class outcome treatment patientID;
model outcome = treatment / dist=binary oddsratio solution;
random patientID;
run;

proc glimmix data=df;
class outcome treatment patientID;
model outcome = visit / dist=binary oddsratio solution;
random patientID;
run;

proc glimmix data=df;
class outcome treatment patientID;
model outcome = treatment treatment*visit / dist=binary oddsratio solution;
random patientID;
run;