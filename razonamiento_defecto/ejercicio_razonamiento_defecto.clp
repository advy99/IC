; Antonio David Villegas Yeguas
; Ejercicio razonamiento por defecto

;;;;;;;;;;;;;;;Representación;;;;;;;;;;;;;;;

; (ave ?x) representa "?x es un ave"
; (animal ?x) representa "?x es una animal"
; (vuela ?x si|no seguro|por_defecto) representa "?x vuela si|no con esa certeza"



; Las aves y los mamíferos son animales
; Los gorriones, las palomas, las águilas y los pinguinos son aves
; La vaca, los perros y los caballos son mamíferos
; Los pinguinos no vuelan

(deffacts datos
	(ave gorrion)
	(ave paloma)
	(ave aguila)
	(ave pinguino)
	(mamifero vaca)
	(mamifero perro)
	(mamifero caballo)
	(vuela pinguino no seguro)
)

; Las aves son animales
(defrule aves_son_animales
	(ave ?x)
	=>
	(assert (animal ?x) )
	(bind ?expl (str-cat "sabemos que un " ?x " es un animal porque las aves son un tipo de animal"))
	(assert (explicacion animal ?x ?expl))

)
; añadimos un hecho que contine la explicacion de la deducción

; Los mamiferos son animales (A3)

(defrule mamiferos_son_animales
	(mamifero ?x)
	=>
	(assert (animal ?x))
	(bind ?expl (str-cat "sabemos que un " ?x " es un animal porque los mamiferos son un tipo de animal"))
	(assert (explicacion ?x ?expl))

)

; Casi todas las aves vuelan -> puedo asumir por defecto que las aves vuelan

(defrule ave_vuela_por_defecto
	(declare (salience -1)) ; para reducir probabilidad de añadir erroneamente
	(ave ?x)
	=>
	(assert (vuela ?x si por_defecto))
	(bind ?expl (str-cat "asumo que " ?x " vuela, porque casi todas las aves vuelan"))
	(assert (explicacion vuela ?x ?expl))

)

(defrule retracta_vuela_por_defecto
	(declare (salience 1)) ; para retractar antes de inferir cosas erroneamente)
	?f <- (vuela ?x ?r por_defecto)
	(vuela ?x ?s seguro)
	=>
	(retract ?f)
	(bind ?expl (str-cat "retractamos que un " ?x " vuela por defecto, porque sabemos seguro que " ?x ?s " vuela"))
	(assert (explicacion retracta_vuela ?x ?expl))

)
; esta regla también elimina los por defecto cuando ya esta seguro


; La mayor parte de los animales no vuelan -> puede interesarme asumir por defecto que un animal no va a volar
(defrule mayor_parte_animales_no_vuelan
	(declare (salience -2))
	(animal ?x)
	(not (vuela ?x ? ?))
	=>
	(assert (vuela ?x no por_defecto))
	(bind ?expl (str-cat "asumo que " ?x " no vuela, porque la mayor parte de los animales no vuelan"))
	(assert (explicacion vuela ?x ?expl))
)


; preguntamos al usuario por un animal
(defrule pregunta_animal
	(declare (salience -5))
	(not (ha_preguntado ?))
	=>
	(printout t "Dime un animal ")
	(bind ?res (read))
	(assert (ha_preguntado ?res))

)

; si el animal ya esta en la base de conocimiento respondemos lo que sabemos
(defrule animal_en_base_de_conocimiento
	(declare (salience -10))
	(ha_preguntado ?animal)
	(animal ?animal)
	(explicacion vuela ?animal ?expl)
	(vuela ?animal ?si_no ?estoy_seguro)
	=>
	(printout t ?animal " " ?si_no " vuela ya que " ?expl crlf)
)

; si no esta, preguntamos si es mamifero o ave
(defrule no_esta_en_base_conocimiento_animal
	(declare (salience -11))
	(ha_preguntado ?animal)
	(not (animal ?animal))
	(not (tipo ?animal ?x))
	=>
	(printout t ?animal " es un mamifero o un ave ? [mamifero/ave/no_se] ")
	(assert
		(tipo ?animal (read))
	)

)

; comprobamos que la respuesta dada es correcta, si no lo es volvemos a preguntar
(defrule entrada_correcta
	(declare (salience 99))
	?x <- (tipo ?animal ?respuesta)
	(test
		(and
			(neq ?respuesta mamifero)
			(and
				(neq ?respuesta ave)
				(neq ?respuesta no_se)
			)
		)
	)
	=>
	(printout t "Tienes que responder [mamifero/ave/no_se] " crlf)
	(retract ?x)
)


; si la respuesta es ave, introducimos ave, el sistema decidirá si vuela o no (por defecto si)
(defrule entrada_tipo_ave
	(declare (salience -15))
	?x <- (tipo ?animal ?respuesta)
	(test (eq ?respuesta ave))
	=>
	(assert (ave ?animal))
	(retract ?x)

)

; si la respuesta es mamifero, introducimos mamifero, el sistema decidirá si vuela o no (por defecto no)
(defrule entrada_tipo_mamifero
	(declare (salience -15))
	?x <- (tipo ?animal ?respuesta)
	(test (eq ?respuesta mamifero))
	=>
	(assert (mamifero ?animal))
	(retract ?x)

)

; si la respuesta es no se, introducimos que es un animal, el sistema decidirá si vuela o no (por defecto no)
(defrule entrada_tipo_no_se
	(declare (salience -15))
	?x <- (tipo ?animal ?respuesta)
	(test (eq ?respuesta no_se))
	=>
	(assert (animal ?animal))
	(retract ?x)

)
