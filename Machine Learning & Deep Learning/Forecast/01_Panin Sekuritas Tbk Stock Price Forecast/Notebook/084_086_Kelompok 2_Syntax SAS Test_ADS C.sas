data latihan;
input y1;
datalines;
1.365
1.385
1.43
1.425
1.43
1.48
1.5
1.495
1.475
1.48
1.51
1.53
1.56
1.565
1.525
1.51
1.48
1.46
1.49
1.515
1.51
1.525
1.535
1.555
1.57
1.59
1.61
1.605
1.605
1.61
1.62
1.615
1.61
1.59
1.575
1.565
1.56
1.565
1.55
1.56
1.56
1.58
1.595
1.595
;
proc arima data=latihan;                                                                                                                  
identify var=y1(1) nlag=48 noprint;                                                                                                     
run;                                                                                                                                    
estimate
p=(1 10 16)
q=(1 2 6)
noconstant method=cls;
forecast lead=12 out=arimaout printall;                                                                                                                        
run;

proc univariate data=arimaout normal;
var residual;
run;











































