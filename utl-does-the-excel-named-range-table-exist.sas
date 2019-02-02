Does the excel named range table exist                                                        
                                                                                              
Note when you create a tables with the libname                                                
emgine it creates a 'named range' ODBC table.                                                 
ODBC tables are muuch more useful than 'sheet names'.                                         
ie modify, update, passthru joins ....                                                        
                                                                                              
                                                                                              
INPUT                                                                                         
=====                                                                                         
                                                                                              
%utlfkil("d:/xls/class.xlsx"); * delete if exist;                                             
                                                                                              
libname xel "d:/xls/class.xlsx";                                                              
                                                                                              
data xel.males;                                                                               
  set sashelp.class(where=(sex='M'));                                                         
run;quit;                                                                                     
                                                                                              
libname xel clear;                                                                            
                                                                                              
  d:/xls/class.xlsx                                                                           
                                                                                              
     +----------------------------------------------------------------+                       
     |     A      |    B       |     C      |    D       |    E       |                       
     +----------------------------------------------------------------+                       
   1 | NAME       |   SEX      |    AGE     |  HEHT    |  WEHT        |                       
     +------------+------------+------------+------------+------------+                       
   2 | ALFRED     |    M       |    14      |    69      |  112.5     |                       
     +------------+------------+------------+------------+------------+                       
      ...                                                                                     
     +------------+------------+------------+------------+------------+                       
  11 | WILLIAM    |    M       |    15      |   66.5     |  112       |                       
     +------------+------------+------------+------------+------------+                       
                                                                                              
   [class]                                                                                    
                                                                                              
   Excel Formulas>name manager                                                                
                                                                                              
   Name     Refers to          Scope                                                          
   ------------------------------------                                                       
   Males    =males!A$1:E$11    Workbook                                                       
                                                                                              
                                                                                              
PROCESS                                                                                       
=======                                                                                       
                                                                                              
libname xel "d:/xls/class.xlsx";                                                              
                                                                                              
proc sql;                                                                                     
  select                                                                                      
    memname                                                                                   
  from                                                                                        
    sashelp.vtable                                                                            
  where                                                                                       
    libname = "XEL"   and                                                                     
    memname="males"                                                                           
;quit;                                                                                        
                                                                                              
%put %sysfunc(ifc (&sqlobs = 0,TABLE MALES DOES NOT EXIST,TABLE MALES EXISTS));               
                                                                                              
------------------                                                                            
TABLE MALES EXISTS                                                                            
------------------                                                                            
                                                                                              
* DROP TABLE;                                                                                 
proc sql;                                                                                     
  drop table xel.males                                                                        
;quit;                                                                                        
                                                                                              
proc sql;                                                                                     
  select                                                                                      
    memname                                                                                   
  from                                                                                        
    sashelp.vtable                                                                            
  where                                                                                       
    libname = "XEL"   and                                                                     
    memname="males" ;                                                                         
;quit;                                                                                        
                                                                                              
%put %sysfunc(ifc (&sqlobs = 0,TABLE MALES DOES NOT EXIST,TABLE MALES EXISTS));               
                                                                                              
--------------------------                                                                    
TABLE MALES DOES NOT EXIST                                                                    
--------------------------                                                                    
                                                                                              
