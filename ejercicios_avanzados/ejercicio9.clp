; Antonio David Villegas Yeguas
; ejercicios avanzados de CLIPS - ejercicio 9

; para comenzar el programa
(defrule comenzar_leer
	=>
	(assert
		(leer)
	)
)

;;; lectura
(defrule openfile_read
	(leer)
	=>
	(open "datos.txt" file)
	(assert (SeguirLeyendo))
)

; vamos leyendo hasta encontrar el fin de fichero (EOF)
(defrule readfile
	?f <- (SeguirLeyendo)
	=>
	(bind ?valor (read file))
	(retract ?f)
	(if (neq ?valor EOF) then
		(assert(Dato ?valor))
		(assert(SeguirLeyendo))
	)
)

; cerramos el fichero
(defrule closefile_read
	(declare (salience -5))
	?f <- (leer)
	=>
	(close file)
	(retract ?f)
)

; mostramos los valores leidos
(defrule mostrar_valores_leidos
	(declare (salience -10))
	(Dato ?valor)
	(not (HeMostradoDato ?valor))
	=>
	(printout t "Leido: " ?valor crlf)
	(assert
		(HeMostradoDato ?valor)
	)

)
