; Antonio David Villegas Yeguas

; ejercicio 1 - lo he adaptado de mi práctica 1 ya que estaba realizando esas comprobaciones

; preguntas para obtener el conocimiento
; si no he aconsejado o respondido todo y si no he preguntado ya esto
(defrule preguntar_opcion
	(not (OpcionElegida ?x))
	=>
	(printout t "¿Te gustan las matemáticas?[me_encanta/lo_soporto/lo_odio/no_se]" crlf)
	(assert (OpcionElegida (read)))
)


; comprobacion de las entradas
(defrule comprobar_entrada_gusta
	(declare (salience 9))
	?x <- (OpcionElegida ?valor)
	(test (and (neq ?valor me_encanta) (and (neq ?valor lo_soporto) (and (neq ?valor lo_odio) (neq ?valor no_se)) ) ))
	=>
	(printout t "Por favor responde me_encanta, lo_soporto, lo_odio o no_se" crlf)
	(retract ?x)
)


(defrule mostrar_opcion_elegida
	(OpcionElegida ?valor)
	=>
	(printout t "Has escogido la opcion " ?valor crlf)

)
