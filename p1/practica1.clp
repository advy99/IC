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

(defrule comienzo
	=>

)




(defrule aconsejar_rama
	(consejo ?rama ?motivo ?apodo)
	=>
	(printout t "Te aconsejo escoger la rama " ?rama " ya que " ?motivo crlf)


)
