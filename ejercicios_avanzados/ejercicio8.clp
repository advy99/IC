;;; escritura
(deffacts datos
	(WRITE cosa1 cosa2 hola adios)
)



(defrule write
	?f <- (WRITE $?datos)
	=>
	(open "datos.txt" file "w")
	(printout file $?datos)
	(close file)
	(retract ?f)
	(assert (leer) )
)
