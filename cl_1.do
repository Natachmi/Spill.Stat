<<<<<<< HEAD
*Primera clase: Miércoles 13/jun/2018

***********
*Protocolo*
*********** 

********************************************************************************
********************************************************************************
***               This code is property of FUNDACION ARU                     ***
********************************************************************************
********************************************************************************
***      Author1 : 
***      Author2 : 
***      Comments: 
********************************************************************************
***      Program : Módulo de capacitación
***      Version : 01              
***      Objetive: Capacitación introductoria en Stata
********************************************************************************
clear all 
global do "C:\Users\Laura\Dropbox\dofiles"
global dta "C:\Users\Laura\Dropbox\dtafiles"
global gph "C:\Users\Laura\Dropbox\gphfiles"
global log "C:\Users\Laura\Dropbox\logfiles"
global out "C:\Users\Laura\Dropbox\outfiles"


**********************************
*Exportar-Importar bases de datos*
********************************** 
use $dta\EH2016_Persona.dta, clear
save $dta\EH2016_Persona_v1.dta, replace
saveold $dta\EH2016_Persona_v1.dta, replace


**********
*Comandos*
**********
note: Comandos descriptivos 
note: Stata distingue entre mayúsculas y minúsculas, de forma que las variables /*
*/    var1 y Var1 son distintas. 
note: La sintanxis básica comando lista de variables [if expression] /*
*/    [in expression], [opciones] 
note: help


*Ejercicios 1: Comandos descriptivos
sum /* summarize*/
sum s02a_02
sum s02a_02 [w=factor]

des /*describe*/
des s02a_02 

codebook
help codebook

sort folio

br

edit

*Ejercicio 2: Rename variables
rename s02a_03 edad
label var edad "Edad"


*Ejercicio 5: Tab
=======

*.. crear variables

*Sexo
capture drop sexo
gen sexo=s02a_02

label var sexo "Sexo"
label def sexo 1 "Hombre"  2 "Mujer" , add
label values sexo sexo 

*Civil
capture drop civil
gen civil=s02a_10

label var civil "Estado civil"
label def civil 1 "Soltero"  2 "casado" 3 "Conviviente o concubino" 4 "Separado" 5 "Divorciado" 6 "Viudo", add
label values civil civil



* Tabulate 

/* El comando tabulate (tab) es muy utilizado a la hora de visualizar estadisticas descriptivas */

*h tab

tab s02a_02
tab sexo // Hombre o mujer

tab sexo,  m 
tab sexo, nofreq


tab civil,m 

* Queremos ver la cantidad de mujeres casadas
tab sexo civil,m 
* Queremos ver el porcnetaje de mujeres casadas
tab sexo civil,m col // del 100% de la población casada, 49.49% son mujeres
tab sexo civil,m row // del 100% de mujeres, 26.91% están casadas.
tab sexo civil,m col no freq

* EJERCICIO
* Qué porcentaje de las mujeres están embarazadas a la hora de hacer la encuesta 2017? 
*Presentar resultados en una tabla bajo el nombre de muejres embarazadas
tab s04b_11a
* Qué porcentaje de mujeres estuvo o esta embarazada? 

*Embarazos
capture drop embarazos
gen embarazos=s04b_11a

label var  ""
label def  1 ""  2 "" 3 "" , add
label values 

tab sexo embarazos, m row matrow(a)
tab sexo embarazos, m row matcol(b)
tab sexo embarazos, m row matcell(aux)




>>>>>>> 5ea5e3f884d390d9d98bfd57334d6680d55ac52d
