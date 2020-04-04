;Así, la práctica consiste en crear un programa en CLIPS que:
;Le pregunte al usuario que pide asesoramiento lo que le preguntaría el compañero que hace de experto.
;Realice los razonamientos que haría el compañero que hace de experto
;Le aconseje la rama o las ramas que le aconsejaría el compañero junto con los motivos por los que se lo aconsejaría.


;Para representar las ramas utilizaremos los siguientes hechos:

;(deffacts Ramas
;(Rama Computacion_y_Sistemas_Inteligentes)
;(Rama Ingenieria_del_Software)
;(Rama Ingenieria_de_Computadores)
;(Rama Sistemas_de_Informacion)
;(Rama Tecnologias_de_la_Informacion)
;)

;Para representar que el sistema aconseja elegir una rama <nombre de la rama> por el motivo “<texto del motivo>” utilizaremos el hecho

;(Consejo <nombre de la rama> “<texto del motivo>”  “apodo del experto”)

;El sistema debe utilizar las propiedades o características que emplearía el experto para realizar el consejo. Hay que incluir al principio del fichero un comentario indicando las propiedades que usa el experto, los valores que pueden tomar y cómo se representan en el sistema.

;Por ejemplo, si el experto usa la propiedad de qué calificación media ha obtenido en las asignaturas de los años anteriores y después las considera como Alta Media o Baja, podríamos incluir:

;;;;  El experto utiliza la calificación media obtenida, tomando valores de Alta, Media ;;;;  o Baja, y se representa por (Calificacion_media Alta|Media|Baja)

;Hay que hacer que el sistema actúe como el experto.
;Siguiendo el ejemplo anterior, si el experto pregunta por la nota media como número y después la califica como Alta,Media o Baja, el sistema debe preguntar por la calificación numérica y después deducir si es alta, media o baja.




(deffacts Ramas
	(Rama Computacion_y_Sistemas_Inteligentes)
	(Rama Ingenieria_del_Software)
	(Rama Ingenieria_de_Computadores)
	(Rama Sistemas_de_Informacion)
	(Rama Tecnologias_de_la_Informacion)
)

(defrule comienzo_preguntar_mates
	(declare (salience -9990))
	(not (gusta matematicas ?val))
	(not (consejo ?rama ?motivo))
	=>
	(printout t "¿Te gustan las matemáticas?[si/no]" crlf)
	(assert (gusta matematicas (read)))
)


(defrule preguntar_hardware
	(declare (salience -9991))
	(not (gusta hardware ?val))
	(not (consejo ?rama ?motivo ?apodo))
	=>
	(printout t "¿Te gusta el hardware?[si/no]" crlf)
	(assert (gusta hardware (read)))
)

(defrule preguntar_programar
	(declare (salience -9992))
	(not (gusta programar ?val))
	(not (consejo ?rama ?motivo ?apodo))
	=>
	(printout t "¿Te gusta programar?[si/no]" crlf)
	(assert (gusta programar (read)))
)

(defrule preguntar_trabajo
	(declare (salience -9997))
	(not (trabajaria_en ?val))
	(not (consejo ?rama ?motivo ?apodo))
	=>
	(printout t "¿En que te gustaría trabajar?[docencia/empresa_privada/empresa_publica]" crlf)
	(assert (trabajaria_en (read)))
)





(defrule comprobar_entrada_gusta
	(declare (salience 9999))
	?x <- (gusta ?algo ?valor)
	(test (and (neq ?valor si) (neq ?valor no) ))
	=>
	(printout t "Por favor responde si o no" crlf)
	(retract ?x)
)

(defrule comprobar_entrada_trabajo
	(declare (salience 9999))
	?x <- (trabajaria_en ?valor)
	(test (and (neq ?valor docencia) (and  (neq ?valor empresa_publica)  (neq ?valor empresa_privada )) ))
	=>
	(printout t "Por favor responde docencia, empresa_privada o empresa_publica" crlf)
	(retract ?x)
)


(defrule aconsejor_csi
	(declare (salience 9991))
	(gusta matematicas si)
	=>
	(assert
		(consejo Computacion_y_Sistemas_Inteligentes te_gustan_matematicas Antonio)
	)

)

(defrule aconsejar_ic
	(declare (salience 9991))
	(gusta matematicas no)
	(gusta hardware si)
	(gusta programar no)
	=>
	(assert
		(consejo Ingenieria_de_Computadores te_gusta_hardware Antonio)
	)
)

(defrule aconsejar_is_hardware
	(declare (salience 9991))
	(gusta matematicas no)
	(gusta hardware si)
	(gusta programar si)
	=>
	(assert
		(consejo Ingenieria_del_Software te_gusta_programar Antonio)
	)
)

(defrule aconsejar_is_docencia
	(declare (salience 9991))
	(gusta matematicas no)
	(gusta hardware no)
	(gusta programar si)
	(or
		(trabajaria_en docencia)
		(trabajaria_en empresa_publica)
	)
	=>
	(assert
		(consejo Ingenieria_del_Software te_gusta_programar Antonio)
	)
)

(defrule aconsejar_si
	(declare (salience 9991))
	(gusta matematicas no)
	(gusta hardware no)
	(gusta programar si)
	(trabajaria_en empresa_privada)
	=>
	(assert
		(consejo Sistemas_de_Informacion te_gustaria_trabajar_en_empresa Antonio)
	)
)


(defrule aconsejar_ti
	(declare (salience 9991))
	(gusta matematicas no)
	(gusta hardware no)
	(gusta programar no)
	=>
	(assert
		(consejo Tecnologias_de_la_Informacion no_te_gustarian_otras_ramas Antonio)
	)
)



(defrule aconsejar_rama
	(declare (salience 9990))
	(consejo ?rama ?motivo ?apodo)
	=>
	(printout t "El experto " ?apodo " te aconseja escoger la rama " ?rama " ya que " ?motivo crlf)

)
