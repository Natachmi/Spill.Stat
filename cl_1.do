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
global dta "C:\Users\hp\Desktop\BASE_DE_DATOS\EH2016"
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
*label var edad "Edad"
*rename s02a_03 edad
*note: describir media y desviacion estandar de la variable de edad, por grupos de eda
sum edad if edad>=7

*Ejercicio 5: Tabulate
*sexo
capture drop sexo
rename s02a_02 sexo
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

capture drop embarazo
gen embarazo=s04b_11a 

tab sexo embarazo [w=factor] ,m row

*Ejercicio 6: Keep Drop preserve restore
*Para eliminar observaciones inecesarias en la base de datos
tab edad embarazos

keep if edad<=18 // eliminamos obervaciones innecesarias
sort edad
drop if edad>=18 
*************************************************************************
clear all
global out= "C:\Users\NATALY\Dropbox\ARU\Investigación\TATO\Armonizacion\dta\out"
global in= "C:\Users\NATALY\Dropbox\ARU\Investigación\TATO\Armonizacion\dta\in"

use $in\eh2016_personas.dta, clear

*sexo
capture drop sexo
rename s02a_02 sexo
*Edad
capture drop edad
rename s02a_03 edad

*Civil
capture drop civil
gen civil=s02a_10

*embarazo
capture drop embarazo
gen embarazo=s04b_11a 

label var civil "Estado civil"
label def civil 1 "Soltero"  2 "casado" 3 "Conviviente o concubino" 4 "Separado" 5 "Divorciado" 6 "Viudo", add
label values civil civil
/*
preserve 
 drop if edad>18 
 save $out/bd2aux.dta, replace // ni;os ni;as adolescentes
 *save "C:\Users\NATALY\Dropbox\ARU\Investigación\TATO\Armonizacion\dta\out\baseejemplo.dta, replace
 restore 

preserve 
 drop if edad>12 
 save $out/bd2aux.dta, replace // embarazo
restore 
*/


*Ejercicio 7: Comentarios
note: cuatro formas de hacer comentarios
* Asterisco
// Doble barra
/**/ //barra asterisco
/// 

*Ejercicio 8: Table
tab year female
 
table sexo, c (mean civil) 
table sexo  if edad>12, c (mean civil) 

* Ejercicio table con otra base de datos
*************************************************************************

tab year female if marital==1
bys year: tab female marital if edad==15

* yalljb = ingreso laboral
table year, c (mean yalljb count yalljb p90  yalljb p25 yalljb )

logout, save ($tabl/control/tb_vc1) excel replace: table year, c (mean yalljb count yalljb p90  yalljb p25 yalljb )
*************************************************************************

*Ejercicio 9: REG  lineal
*crear experiencia potencial

capture drop exper
gen exper=edad-6-e

capture drop lnylab
gen lnylab=log(ylab)

reg lnylab exper e civil // ndepto //MCO
bys marital: tab year female, m col

**********
*Gr�ficos*
**********
cap drop sexo_*
tab sexo, gen(sexo_)

tabstat dp_*, col(stat)

graph bar sexo_*, percent bargap(10) outergap(10) /*
*/ scheme(s1color) legend(label(1 "Hombre") label(2 "Mujer") /*
*/ cols(2)) blabel(bar,format(%9.2f)) ylabel(0(20)100)
graph export $gph\sexo.png, replace

graph bar sexo_*, percent 
graph hbar sexo_*, percent over(civil)
graph hbar sexo_*, stack percent over(civil)
graph hbar sexo_*, over(civil) over(depto) by(rural, cols(1) note(""))

twoway dropline poblacion year, mlabel(poblacion) yaxis(1)  || connected share year, /*
*/ msymbol(Sh) mlabel(share) yaxis(2) scheme(s2color8)

twoway connected var1 var2
twoway dot var1 var2
twoway scatter var1 var2, msymbol(+) (lfit var1 var2)
graph dot
graph pie sexo, over(civil)
*******
*loops*
*******
*Loops //forvalues  o forv
forv p=0(3)100{
gen var_`p'=`p'
}
cap drop y
gen y=0
forv x=0(3)100{
replace y=`x'
}
forv x=1/2{
display `x' //muestra lo que esta sacando
mean ylab if sexo==`x'
}

global p "sexo edad"
foreach i of local p{
rename `i' `i'_1
}


