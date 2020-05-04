
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

(defrule closefile_read
	(declare (salience -5))
	?f <- (leer)
	=>
	(close file)
	(retract ?f)
)


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
