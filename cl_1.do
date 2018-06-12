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


*Ejercicios 3: Creacion de variables dummy
capture drop mujer
gen mujer=.
replace mujer=1 if s02a_02==2
replace mujer=0 if s02a_02==1

label define mujer 0 "Hombre"
label define mujer 1 "Mujer", add
label val mujer mujer
label var mujer "Variable dummy"

cap drop mujer1
gen byte mujer1=(s02a_02==1)

cap drop edad_5_10
gen edad_5_10=edad if edad>=5 & edad<=10
label var edad_5_10 "Grupo de edad de 5 a 10 años"

cap drop edad_11_15
gen byte edad_11_14=(edad>10 & edad<16)

tab s02a_05, gen(parentesco)
tab parentesco1

*Ejercicio 4: Comando egen
cap drop total_mujer
gen total_mujer=sum(mujer)


cap drop total_mujer1
egen total_mujer1=sum(mujer)


*Ejercicio 5: Tab

*Civil
capture drop civil
gen civil=s02a_10

label var civil "Estado civil"
label def civil 1 "Soltero"  2 "casado" 3 "Conviviente o concubino" 4 "Separado" 5 "Divorciado" 6 "Viudo", add
label values civil civil


* Tabulate   
/* El comando tabulate (tab) es muy utilizado a la hora de visualizar estadisticas descriptivas */
*h tab

tab mujer // Hombre o mujer

tab mujer,  m 
tab mujer, nofreq


tab civil,m 

* Queremos ver la cantidad de mujeres casadas
tab mujer civil,m 
* Queremos ver el porcnetaje de mujeres casadas
tab mujer civil,m col // del 100% de la población casada, 49.49% son mujeres
tab mujer civil,m row // del 100% de mujeres, 26.91% están casadas.
tab mujer civil,m col no freq

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

tab mujer embarazos, m row matrow(a)
tab mujer embarazos, m row matcol(b)
tab mujer embarazos, m row matcell(aux)


