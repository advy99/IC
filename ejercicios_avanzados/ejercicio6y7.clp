(deftemplate Jugadores
	(field Nombre)
	(field Altura)
)

(deffacts jugadores_iniciales
	(Jugadores
		(Nombre J1)
		(Altura 180)
	)
	(Jugadores
		(Nombre J2)
		(Altura 160)
	)
	(Jugadores
		(Nombre J3)
		(Altura 196)
	)
	(Jugadores
		(Nombre J4)
		(Altura 192)
	)
)

; hago parejas y selecciono los mas altos
(defrule inicio_mas_alto
	(declare (salience 99))
	(Jugadores (Nombre ?n1) (Altura ?altura1))
	(not (inicio_j_mas_alto))
	=>
	(assert
		(mas_alto ?n1 ?altura1)
		(inicio_j_mas_alto)
	)
)

(defrule mas_alto_total
	(Jugadores (Nombre ?n1) (Altura ?altura1))
	?x <- (mas_alto ?n2 ?altura2)
	(test (> ?altura1 ?altura2) )
	(test (neq ?n1 ?n2))
	=>
	(retract ?x)
	(assert
		(mas_alto ?n1 ?altura1)
	)
)

(defrule mostrar_mas_alto
	(declare (salience -1))
	(mas_alto ?n1 ?altura1)
	=>
	(printout t "El más alto es " ?n1 " y mide " ?altura1 crlf)
)
