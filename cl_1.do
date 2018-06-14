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

list

des /*describe*/
des s02a_02 

codebook
help codebook

sort folio
note: ordena la base de datos

br /*browser*/
note: Abre el visualizador de datos o lo coloca al frente de las otras ventanas de Stata

edit /*editor*/
note: Abre el editor de datos o lo coloca al frente de las otras ventanas de Stata 

break
note: Interrumpe lo que esté haciendo Stata. 

clear all
note: limpia todo

*Operadores logicos
note: < menor que
note: <= menor o igual que
note: == igual que
note: > mayor que
note: >= mayor o igual que
note: != no es igual
note: & la conjucion "y"
note: | la conjuncion "o"
note: "Varible de texto"

*Ejercicio 2: Rename variables y descripcion de variables
label var edad "Edad"
rename s02a_03 edad
note: describir media y desviacion estandar de la variable de edad, por grupos de edad

sum edad if edad>=7


*Ejercicio 5: Tabulate
*Edad
capture drop edad
rename s02a_03 edad

*Civil
capture drop civil
gen civil=s02a_10

label var civil "Estado civil"
label def civil 1 "Soltero"  2 "casado" 3 "Conviviente o concubino" 4 "Separado" 5 "Divorciado" 6 "Viudo", add
label values civil civil

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

* Qué porcentaje de las mujeres están embarazadas a la hora de hacer la encuesta 2017? 
*Presentar resultados en una tabla bajo el nombre de muejres embarazadas

/* EJERCICIO Resuelto
tab s04b_11a
* Qué porcentaje de mujeres estuvo o esta embarazada? 

*Embarazos
/*capture drop embarazos
gen embarazos=s04b_11a

label var  ""
label def  1 ""  2 "" 3 "" , add
label values 

tab mujer embarazos, m row matrow(a)
tab mujer embarazos, m row matcol(b)
tab mujer embarazos, m row matcell(aux) */ */


*Ejercicio 6: Keep Drop 
*Para eliminar observaciones inecesarias en la base de datos
tab edad embarazos
keep if edad>=13 // eliminamos obervaciones innecesarias
drop if edad>=13 

use $dta\EH2016_Persona.dta, clear

preserve 
drop if edad>=13 
 tempfile table2
 save `table2', replace
 export excel using "C:\Users\NATALY\Dropbox\ARU\Investigación\TATO\Mercado_Laboral\Modulo_mercado_laboral\tabl\tab1an234.xlsx", replace firstrow(var) 
restore 

*Ejercicio 7: comentarios
note: cuatro formas de hacer comentarios
* Asterisco
// Doble barra
/**/ //barra asterisco

*Ejercicio 8: Table 
table sexo, c (mean civil) 
table sexo  if edad>12, c (mean civil) 


*Ejercicio 9: REG  lineal
* crear experiencia potencial
reg ylab edad exper niv_ed civil depto

*Ejercicio 10: Reg prob/logit
prob ylab edad exper niv_ed civil depto

