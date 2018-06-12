
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




