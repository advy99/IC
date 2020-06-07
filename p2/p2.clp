; Antonio David Villegas Yeguas

;Así, la práctica consiste en crear un programa en CLIPS que:
;Le pregunte al usuario que pide asesoramiento lo que le preguntaría el compañero que hace de experto.
;Realice los razonamientos que haría el compañero que hace de experto
;Le aconseje la rama o las ramas que le aconsejaría el compañero junto con los motivos por los que se lo aconsejaría.


; las ramas serán csi, ic, si, it y is

;Para representar las ramas utilizaremos los siguientes hechos:

;(recomendacion <rama> puntuacion)

; donde la puntuacion será una discretización de las preguntas que haremos al usuario
; acorde a como el experto interpreta la importancia de un campo sobre las distintas ramas

;Para representar que el sistema aconseja elegir una rama <nombre de la rama> por el motivo “<texto del motivo>” utilizaremos el hecho

;(Consejo <nombre de la rama> “<texto del motivo>”  “apodo del experto”)

;El sistema debe utilizar las propiedades o características que emplearía el experto para realizar el consejo. Hay que incluir al principio del fichero un comentario indicando las propiedades que usa el experto, los valores que pueden tomar y cómo se representan en el sistema.

;Por ejemplo, si el experto usa la propiedad de qué calificación media ha obtenido en las asignaturas de los años anteriores y después las considera como Alta Media o Baja, podríamos incluir:

;;;;  El experto utiliza la calificación media obtenida, tomando valores de Alta, Media ;;;;  o Baja, y se representa por (Calificacion_media Alta|Media|Baja)

;Hay que hacer que el sistema actúe como el experto.
;Siguiendo el ejemplo anterior, si el experto pregunta por la nota media como número y después la califica como Alta,Media o Baja, el sistema debe preguntar por la calificación numérica y después deducir si es alta, media o baja.


; puntuaciones de cada pregunta para cada rama
(deffacts puntuaciones_CSI
	(puntuacion csi gusta_matematicas me_encanta 120)
	(puntuacion csi gusta_matematicas lo_soporto 30)
	(puntuacion csi gusta_matematicas lo_odio -100)
	(puntuacion csi gusta_matematicas no_se 0)

	(puntuacion csi gusta_programar me_encanta 50)
	(puntuacion csi gusta_programar lo_soporto 30)
	(puntuacion csi gusta_programar lo_odio -30)
	(puntuacion csi gusta_programar no_se 0)

	(puntuacion csi gusta_hardware me_encanta -70)
	(puntuacion csi gusta_hardware lo_soporto -20)
	(puntuacion csi gusta_hardware lo_odio 30)
	(puntuacion csi gusta_hardware no_se 0)

	(puntuacion csi nota_media alta 30)
	(puntuacion csi nota_media media 15)
	(puntuacion csi nota_media baja 0)
	(puntuacion csi nota_media no_quiero_contestar 0)

	(puntuacion csi gustaria_trabajar docencia 20)
	(puntuacion csi gustaria_trabajar investigacion 30)
	(puntuacion csi gustaria_trabajar empresa_privada 15)
	(puntuacion csi gustaria_trabajar empresa_publica 15)
	(puntuacion csi gustaria_trabajar no_quiero_contestar 0)

	(puntuacion csi trabajador mucho 30)
	(puntuacion csi trabajador algo 10)
	(puntuacion csi trabajador nada -10)
	(puntuacion csi trabajador no_quiero_contestar 0)
)

(deffacts puntuaciones_IS
	; puntuacion_is para cada pregunta
	(puntuacion is gusta_matematicas me_encanta -60)
	(puntuacion is gusta_matematicas lo_soporto -20)
	(puntuacion is gusta_matematicas lo_odio 50)
	(puntuacion is gusta_matematicas no_se 0)

	(puntuacion is gusta_programar me_encanta 100)
	(puntuacion is gusta_programar lo_soporto 60)
	(puntuacion is gusta_programar lo_odio -70)
	(puntuacion is gusta_programar no_se 0)

	(puntuacion is gusta_hardware me_encanta -80)
	(puntuacion is gusta_hardware lo_soporto -20)
	(puntuacion is gusta_hardware lo_odio 30)
	(puntuacion is gusta_hardware no_se 0)

	(puntuacion is nota_media alta 20)
	(puntuacion is nota_media media 20)
	(puntuacion is nota_media baja 10)
	(puntuacion is nota_media no_quiero_contestar 0)

	(puntuacion is gustaria_trabajar docencia 40)
	(puntuacion is gustaria_trabajar investigacion 30)
	(puntuacion is gustaria_trabajar empresa_privada 20)
	(puntuacion is gustaria_trabajar empresa_publica 30)
	(puntuacion is gustaria_trabajar no_quiero_contestar 0)

	(puntuacion is trabajador mucho 30)
	(puntuacion is trabajador algo 10)
	(puntuacion is trabajador nada -20)
	(puntuacion is trabajador no_quiero_contestar 0)
)

(deffacts puntuaciones_IC
	; puntuacion_csies para cada pregunta
	(puntuacion ic gusta_matematicas me_encanta 20) ; para CSI o IS
	(puntuacion ic gusta_matematicas lo_soporto 10) ; IS o CSI
	(puntuacion ic gusta_matematicas lo_odio -10) ; ramas sin matemáticas: IC, TI o SI
	(puntuacion ic gusta_matematicas no_se 0) ; no se que hacer

	(puntuacion ic gusta_programar me_encanta 20)
	(puntuacion ic gusta_programar lo_soporto 10)
	(puntuacion ic gusta_programar lo_odio 0)
	(puntuacion ic gusta_programar no_se 0)

	(puntuacion ic gusta_hardware me_encanta 120)
	(puntuacion ic gusta_hardware lo_soporto 40)
	(puntuacion ic gusta_hardware lo_odio -70)
	(puntuacion ic gusta_hardware no_se 0)

	(puntuacion ic nota_media alta 40)
	(puntuacion ic nota_media media 30)
	(puntuacion ic nota_media baja 10)
	(puntuacion ic nota_media no_quiero_contestar 0)

	(puntuacion ic gustaria_trabajar docencia 20)
	(puntuacion ic gustaria_trabajar investigacion 30)
	(puntuacion ic gustaria_trabajar empresa_privada 20)
	(puntuacion ic gustaria_trabajar empresa_publica 10)
	(puntuacion ic gustaria_trabajar no_quiero_contestar 0)

	(puntuacion ic trabajador mucho 20)
	(puntuacion ic trabajador algo 10)
	(puntuacion ic trabajador nada -10)
	(puntuacion ic trabajador no_quiero_contestar 0)
)

(deffacts puntuaciones_TI
	; puntuacion_csies para cada pregunta
	(puntuacion ti gusta_matematicas me_encanta -60) ; para CSI o IS
	(puntuacion ti gusta_matematicas lo_soporto -30) ; IS o CSI
	(puntuacion ti gusta_matematicas lo_odio 60) ; ramas sin matemáticas: IC, TI o SI
	(puntuacion ti gusta_matematicas no_se 0) ; no se que hacer

	(puntuacion ti gusta_programar me_encanta -30)
	(puntuacion ti gusta_programar lo_soporto 10)
	(puntuacion ti gusta_programar lo_odio 70)
	(puntuacion ti gusta_programar no_se 0)

	(puntuacion ti gusta_hardware me_encanta -10)
	(puntuacion ti gusta_hardware lo_soporto 10)
	(puntuacion ti gusta_hardware lo_odio 30)
	(puntuacion ti gusta_hardware no_se 0)

	(puntuacion ti nota_media alta 5)
	(puntuacion ti nota_media media 20)
	(puntuacion ti nota_media baja 30)
	(puntuacion ti nota_media no_quiero_contestar 0)

	(puntuacion ti gustaria_trabajar docencia 20)
	(puntuacion ti gustaria_trabajar investigacion 30)
	(puntuacion ti gustaria_trabajar empresa_privada 40)
	(puntuacion ti gustaria_trabajar empresa_publica 40)
	(puntuacion ti gustaria_trabajar no_quiero_contestar 0)

	(puntuacion ti trabajador mucho 20)
	(puntuacion ti trabajador algo 20)
	(puntuacion ti trabajador nada 10)
	(puntuacion ti trabajador no_quiero_contestar 0)
)

(deffacts puntuaciones_SI
	; puntuacion_sies para cada pregunta
	(puntuacion si gusta_matematicas me_encanta -40) ; para CSI o IS
	(puntuacion si gusta_matematicas lo_soporto -20) ; IS o CSI
	(puntuacion si gusta_matematicas lo_odio 20) ; ramas sin matemáticas: IC, TI o SI
	(puntuacion si gusta_matematicas no_se 0) ; no se que hacer

	(puntuacion si gusta_programar me_encanta 50)
	(puntuacion si gusta_programar lo_soporto 25)
	(puntuacion si gusta_programar lo_odio 10)
	(puntuacion si gusta_programar no_se 0)

	(puntuacion si gusta_hardware me_encanta 5)
	(puntuacion si gusta_hardware lo_soporto 40)
	(puntuacion si gusta_hardware lo_odio 15)
	(puntuacion si gusta_hardware no_se 0)

	(puntuacion si nota_media alta 10)
	(puntuacion si nota_media media 30)
	(puntuacion si nota_media baja 20)
	(puntuacion si nota_media no_quiero_contestar 0)

	(puntuacion si gustaria_trabajar docencia 20)
	(puntuacion si gustaria_trabajar investigacion 30)
	(puntuacion si gustaria_trabajar empresa_privada 40)
	(puntuacion si gustaria_trabajar empresa_publica 30)
	(puntuacion si gustaria_trabajar no_quiero_contestar 0)

	(puntuacion si trabajador mucho 30)
	(puntuacion si trabajador algo 20)
	(puntuacion si trabajador nada 10)
	(puntuacion si trabajador no_quiero_contestar 0)
)



; inicio del programa, donde ponemos las recomendaciones a 0
(defrule inicio
	(declare (salience 9999))
	(not (comienzo))
	(not (ya_he_aconsejado))
	=>
	(assert
		(comienzo)
		(recomendacion csi 0)
		; la rama por defecto, tendrá un punto mas de puntuacion
		(recomendacion is 1)
		(recomendacion ic 0)
		(recomendacion ti 0)
		(recomendacion si 0)
		(motivos)
	)
)


; preguntas para obtener el conocimiento
; si no he aconsejado o respondido todo y si no he preguntado ya esto
(defrule preguntar_mates
	(declare (salience -9990))
	(not (ya_he_aconsejado))
	(not (gusta matematicas ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿Te gustan las matemáticas?[me_encanta/lo_soporto/lo_odio/no_se/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (gusta matematicas ?respuesta))
	else (assert (ha_respondido_todo))
	)

)


(defrule preguntar_hardware
	(declare (salience -9991))
	(not (ya_he_aconsejado))
	(not (gusta hardware ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿Te gusta el hardware?[me_encanta/lo_soporto/lo_odio/no_se/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (gusta hardware ?respuesta))
	else (assert (ha_respondido_todo))
	)
)

(defrule preguntar_programar
	(declare (salience -9992))
	(not (ya_he_aconsejado))
	(not (gusta programar ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿Te gusta programar?[me_encanta/lo_soporto/lo_odio/no_se/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (gusta programar ?respuesta))
	else (assert (ha_respondido_todo))
	)
)

(defrule preguntar_nota
	(declare (salience -9993))
	(not (ya_he_aconsejado))
	(not (nota ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿Cuál es tu nota media?[alta/media/baja/no_quiero_contestar/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (nota ?respuesta))
	else (assert (ha_respondido_todo))
	)
)

(defrule preguntar_trabajo
	(declare (salience -9994))
	(not (ya_he_aconsejado))
	(not (trabajaria_en ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿En que te gustaría trabajar?[docencia/investigacion/empresa_privada/empresa_publica/no_quiero_contestar/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (trabajaria_en ?respuesta))
	else (assert (ha_respondido_todo))
	)
)


(defrule preguntar_es_trabajador
	(declare (salience -9995))
	(not (ya_he_aconsejado))
	(not (es_trabajador ?val))
	(not (ha_respondido_todo))
	=>
	(printout t "¿Eres trabajador/a?[mucho/algo/nada/no_quiero_contestar/dime_respuesta]" crlf)
	(bind ?respuesta (read))

	(if (neq ?respuesta dime_respuesta) then (assert (es_trabajador ?respuesta))
	else (assert (ha_respondido_todo))
	)
)









; comprobacion de las entradas
(defrule comprobar_entrada_gusta
	(declare (salience 9999))
	(not (ya_he_aconsejado))
	?x <- (gusta ?algo ?valor)
	?f <- (motivos $?m)
	(not (comprobado ?algo ))
	=>
	(if (and (neq ?valor me_encanta) (and (neq ?valor lo_soporto) (and (neq ?valor lo_odio) (neq ?valor no_se)) ) )
		then
			(printout t "Por favor responde me_encanta, lo_soporto, lo_odio o no_se" crlf)
			(retract ?x)
		else
			(retract ?f)
			(assert (motivos ?valor ?algo , $?m ))
			(assert (comprobado ?algo ))
	)

)

(defrule comprobar_entrada_trabajo
	(declare (salience 9999))
	(not (ya_he_aconsejado))
	?x <- (trabajaria_en ?valor)
	(test (and (neq ?valor docencia) (and  (neq ?valor empresa_publica) (and (neq ?valor empresa_privada ) (and (neq ?valor investigacion ) (neq ?valor no_quiero_contestar) ) ) ) ))
	=>
	(printout t "Por favor responde docencia, empresa_privada o empresa_publica" crlf)
	(retract ?x)
)

(defrule comprobar_entrada_nota
	(declare (salience 9999))
	(not (ya_he_aconsejado))
	?x <- (nota ?valor)
	(test (and (neq ?valor alta) (and  (neq ?valor media) (and (neq ?valor baja ) (neq ?valor no_quiero_contestar )  ) ) ))
	=>
	(printout t "Por favor responde alta, media, baja o no_quiero_contestar" crlf)
	(retract ?x)
)

(defrule comprobar_entrada_trabajador
	(declare (salience 9999))
	(not (ya_he_aconsejado))
	?x <- (es_trabajador ?valor)
	(test (and (neq ?valor mucho) (and  (neq ?valor algo) (and (neq ?valor nada ) (neq ?valor no_quiero_contestar )  ) ) ))
	=>
	(printout t "Por favor responde mucho, algo, nada o no_quiero_contestar" crlf)
	(retract ?x)
)


; comprobamos si tenemos todo el conocimiento
(defrule comprobar_ha_respondido_todo
	(declare (salience 9980))
	(not (ha_respondido_todo))
	(es_trabajador ?val)
	(nota ?n)
	(gusta matematicas ?x)
	(gusta hardware ?x1)
	(gusta programar ?x2)
	(trabajaria_en ?x3)
	=>
	(assert (ha_respondido_todo))
)







(defrule puntuar_mates
	(declare (salience 8000))
	(gusta matematicas ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama gusta_matematicas ?val ?valor)
	(not (he_puntuado_mates ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_mates ?rama)
	)
)

(defrule puntuar_programar
	(declare (salience 8000))
	(gusta programar ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama gusta_programar ?val ?valor)
	(not (he_puntuado_programar ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_programar ?rama)
	)
)

(defrule puntuar_hardware
	(declare (salience 8000))
	(gusta hardware ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama gusta_hardware ?val ?valor)
	(not (he_puntuado_hardware ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_hardware ?rama)
	)
)

(defrule puntuar_nota
	(declare (salience 8000))
	(nota ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama nota_media ?val ?valor)
	(not (he_puntuado_nota ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_nota ?rama)
	)
)

(defrule puntuar_trabajador
	(declare (salience 8000))
	(es_trabajador ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama trabajador ?val ?valor)
	(not (he_puntuado_trabajador ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_trabajador ?rama)
	)
)

(defrule puntuar_trabajo
	(declare (salience 8000))
	(trabajaria_en ?val)
	?x <- (recomendacion ?rama ?puntuacion)
	(puntuacion ?rama gustaria_trabajar ?val ?valor)
	(not (he_puntuado_trabajo ?rama))
	=>
	(retract ?x)
	(assert
		(recomendacion ?rama (+ ?puntuacion ?valor))
		(he_puntuado_trabajo ?rama)
	)
)


(defrule recomendar_csi_mucha_puntuacion
	(recomendacion csi ?puntuacion)
	(test (> ?puntuacion 160))
	=>
	(assert (consejo csi Antonio))
)

(defrule recomendar_is_mucha_puntuacion
	(recomendacion is ?puntuacion)
	(test (> ?puntuacion 160))
	=>
	(assert (consejo is Antonio))
)

(defrule recomendar_si_mucha_puntuacion
	(recomendacion si ?puntuacion)
	(test (> ?puntuacion 160))
	=>
	(assert (consejo si Antonio))

)


(defrule recomendar_ic_mucha_puntuacion
	(recomendacion ic ?puntuacion)
	(test (> ?puntuacion 160))
	=>
	(assert (consejo ic Antonio))
)


(defrule recomendar_ti_mucha_puntuacion
	(recomendacion ti ?puntuacion)
	(test (> ?puntuacion 160))
	=>
	(assert (consejo ti Antonio))

)



(defrule recomendar_csi_ha_respondido_todo
	(ha_respondido_todo)
	(not (ya_he_aconsejado))
	(recomendacion csi ?val_r1)
	(recomendacion ic ?val_r2)
	(recomendacion is ?val_r3)
	(recomendacion si ?val_r4)
	(recomendacion ti ?val_r5)
	(test
		(and
			(> ?val_r1 ?val_r2)
			(and
				(> ?val_r1 ?val_r3)
				(and
					(> ?val_r1 ?val_r4)
					(> ?val_r1 ?val_r5)
				)
			)
		)
	)
	=>
	(assert (consejo csi Antonio))
)

(defrule recomendar_is_ha_respondido_todo
	(ha_respondido_todo)
	(not (ya_he_aconsejado))
	(recomendacion is ?val_r1)
	(recomendacion ic ?val_r2)
	(recomendacion csi ?val_r3)
	(recomendacion si ?val_r4)
	(recomendacion ti ?val_r5)
	(test
		(and
			(> ?val_r1 ?val_r2)
			(and
				(> ?val_r1 ?val_r3)
				(and
					(> ?val_r1 ?val_r4)
					(> ?val_r1 ?val_r5)
				)
			)
		)
	)
	=>
	(printout t "Pntuacion " ?val_r1 crlf)
	(assert (consejo is Antonio))
)


(defrule recomendar_ic_ha_respondido_todo
	(ha_respondido_todo)
	(not (ya_he_aconsejado))
	(recomendacion ic ?val_r1)
	(recomendacion is ?val_r2)
	(recomendacion csi ?val_r3)
	(recomendacion si ?val_r4)
	(recomendacion ti ?val_r5)
	(test
		(and
			(> ?val_r1 ?val_r2)
			(and
				(> ?val_r1 ?val_r3)
				(and
					(> ?val_r1 ?val_r4)
					(> ?val_r1 ?val_r5)
				)
			)
		)
	)
	=>
	(assert (consejo ic Antonio))
)


(defrule recomendar_si_ha_respondido_todo
	(ha_respondido_todo)
	(not (ya_he_aconsejado))
	(recomendacion si ?val_r1)
	(recomendacion ic ?val_r2)
	(recomendacion csi ?val_r3)
	(recomendacion is ?val_r4)
	(recomendacion ti ?val_r5)
	(test
		(and
			(> ?val_r1 ?val_r2)
			(and
				(> ?val_r1 ?val_r3)
				(and
					(> ?val_r1 ?val_r4)
					(> ?val_r1 ?val_r5)
				)
			)
		)
	)
	=>
	(assert (consejo si Antonio))
)



(defrule recomendar_ti_ha_respondido_todo
	(ha_respondido_todo)
	(not (ya_he_aconsejado))
	(recomendacion ti ?val_r1)
	(recomendacion ic ?val_r2)
	(recomendacion csi ?val_r3)
	(recomendacion si ?val_r4)
	(recomendacion si ?val_r5)
	(test
		(and
			(> ?val_r1 ?val_r2)
			(and
				(> ?val_r1 ?val_r3)
				(and
					(> ?val_r1 ?val_r4)
					(> ?val_r1 ?val_r5)
				)
			)
		)
	)
	=>
	(assert (consejo ti Antonio))
)



(defrule mostrar_rama_aconsejada
	(declare (salience 9990))
	(not (ya_he_aconsejado))
	(consejo ?rama ?apodo)
	(motivos $?motivos)
	=>
	(printout t "El experto " ?apodo " te aconseja escoger la rama " ?rama " ya que " $?motivos crlf)
	(assert
		(ya_he_aconsejado)
	)

)
