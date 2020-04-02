;;;;;;; JUGADOR DE 4 en RAYA ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Version de 4 en raya clásico: Tablero de 7x7, donde se introducen fichas por arriba
;;;;;;;;;;;;;;;;;;;;;;; y caen hasta la posicion libre mas abajo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Hechos para representar un estado del juego

;;;;;;; (Turno M|J)   representa a quien corresponde el turno (M maquina, J jugador)
;;;;;;; (Tablero Juego ?i ?j _|M|J) representa que la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)

;;;;;;;;;;;;;;;; Hechos para representar estado del analisis
;;;;;;; (Tablero Analisis Posicion ?i ?j _|M|J) representa que en el analisis actual la posicion i,j del tablero esta vacia (_), o tiene una ficha propia (M) o tiene una ficha del jugador humano (J)
;;;;;;; (Sondeando ?n ?i ?c M|J)  ; representa que estamos analizando suponiendo que la ?n jugada h sido ?i ?c M|J
;;;

;;;;;;;;;;;;; Hechos para representar una jugadas

;;;;;;; (Juega M|J ?columna) representa que la jugada consiste en introducir la ficha en la columna ?columna


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; INICIALIZAR ESTADO


(deffacts Estado_inicial
(Tablero Juego 1 1 _) (Tablero Juego 1 2 _) (Tablero Juego 1 3 _) (Tablero Juego  1 4 _) (Tablero Juego  1 5 _) (Tablero Juego  1 6 _) (Tablero Juego  1 7 _)
(Tablero Juego 2 1 _) (Tablero Juego 2 2 _) (Tablero Juego 2 3 _) (Tablero Juego 2 4 _) (Tablero Juego 2 5 _) (Tablero Juego 2 6 _) (Tablero Juego 2 7 _)
(Tablero Juego 3 1 _) (Tablero Juego 3 2 _) (Tablero Juego 3 3 _) (Tablero Juego 3 4 _) (Tablero Juego 3 5 _) (Tablero Juego 3 6 _) (Tablero Juego 3 7 _)
(Tablero Juego 4 1 _) (Tablero Juego 4 2 _) (Tablero Juego 4 3 _) (Tablero Juego 4 4 _) (Tablero Juego 4 5 _) (Tablero Juego 4 6 _) (Tablero Juego 4 7 _)
(Tablero Juego 5 1 _) (Tablero Juego 5 2 _) (Tablero Juego 5 3 _) (Tablero Juego 5 4 _) (Tablero Juego 5 5 _) (Tablero Juego 5 6 _) (Tablero Juego 5 7 _)
(Tablero Juego 6 1 _) (Tablero Juego 6 2 _) (Tablero Juego 6 3 _) (Tablero Juego 6 4 _) (Tablero Juego 6 5 _) (Tablero Juego 6 6 _) (Tablero Juego 6 7 _)
(Tablero Juego 7 1 _) (Tablero Juego 7 2 _) (Tablero Juego 7 3 _) (Tablero Juego 7 4 _) (Tablero Juego 7 5 _) (Tablero Juego 7 6 _) (Tablero Juego 7 7 _)
(Jugada 0)
)

(defrule Elige_quien_comienza
=>
(printout t "Quien quieres que empieze: (escribre M para la maquina o J para empezar tu) ")
(assert (Turno (read)))
)

;;;;;;;;;;;;;;;;;;;;;;; MUESTRA POSICION ;;;;;;;;;;;;;;;;;;;;;;;
(defrule muestra_posicion
(declare (salience 10))
(muestra_posicion)
(Tablero Juego 1 1 ?p11) (Tablero Juego 1 2 ?p12) (Tablero Juego 1 3 ?p13) (Tablero Juego 1 4 ?p14) (Tablero Juego 1 5 ?p15) (Tablero Juego 1 6 ?p16) (Tablero Juego 1 7 ?p17)
(Tablero Juego 2 1 ?p21) (Tablero Juego 2 2 ?p22) (Tablero Juego 2 3 ?p23) (Tablero Juego 2 4 ?p24) (Tablero Juego 2 5 ?p25) (Tablero Juego 2 6 ?p26) (Tablero Juego 2 7 ?p27)
(Tablero Juego 3 1 ?p31) (Tablero Juego 3 2 ?p32) (Tablero Juego 3 3 ?p33) (Tablero Juego 3 4 ?p34) (Tablero Juego 3 5 ?p35) (Tablero Juego 3 6 ?p36) (Tablero Juego 3 7 ?p37)
(Tablero Juego 4 1 ?p41) (Tablero Juego 4 2 ?p42) (Tablero Juego 4 3 ?p43) (Tablero Juego 4 4 ?p44) (Tablero Juego 4 5 ?p45) (Tablero Juego 4 6 ?p46) (Tablero Juego 4 7 ?p47)
(Tablero Juego 5 1 ?p51) (Tablero Juego 5 2 ?p52) (Tablero Juego 5 3 ?p53) (Tablero Juego 5 4 ?p54) (Tablero Juego 5 5 ?p55) (Tablero Juego 5 6 ?p56) (Tablero Juego 5 7 ?p57)
(Tablero Juego 6 1 ?p61) (Tablero Juego 6 2 ?p62) (Tablero Juego 6 3 ?p63) (Tablero Juego 6 4 ?p64) (Tablero Juego 6 5 ?p65) (Tablero Juego 6 6 ?p66) (Tablero Juego 6 7 ?p67)
(Tablero Juego 7 1 ?p71) (Tablero Juego 7 2 ?p72) (Tablero Juego 7 3 ?p73) (Tablero Juego 7 4 ?p74) (Tablero Juego 7 5 ?p75) (Tablero Juego 7 6 ?p76) (Tablero Juego 7 7 ?p77)
=>
(printout t crlf)
(printout t 1 " " 2 " " 3 " " 4 " " 5 " " 6 " " 7 crlf)
(printout t ?p11 " " ?p12 " " ?p13 " " ?p14 " " ?p15 " " ?p16 " " ?p17 crlf)
(printout t ?p21 " " ?p22 " " ?p23 " " ?p24 " " ?p25 " " ?p26 " " ?p27 crlf)
(printout t ?p31 " " ?p32 " " ?p33 " " ?p34 " " ?p35 " " ?p36 " " ?p37 crlf)
(printout t ?p41 " " ?p42 " " ?p43 " " ?p44 " " ?p45 " " ?p46 " " ?p47 crlf)
(printout t ?p51 " " ?p52 " " ?p53 " " ?p54 " " ?p55 " " ?p56 " " ?p57 crlf)
(printout t ?p61 " " ?p62 " " ?p63 " " ?p64 " " ?p65 " " ?p66 " " ?p67 crlf)
(printout t ?p71 " " ?p72 " " ?p73 " " ?p74 " " ?p75 " " ?p76 " " ?p77 crlf)
(printout t  crlf)
)


;;;;;;;;;;;;;;;;;;;;;;; RECOGER JUGADA DEL CONTRARIO ;;;;;;;;;;;;;;;;;;;;;;;
(defrule mostrar_posicion
(declare (salience 9999))
(Turno J)
=>
(assert (muestra_posicion))
)



(defrule juega_contrario_check_entrada_correcta
(declare (salience 1))
?f <- (Juega J ?c)
(test (and (neq ?c 1) (and (neq ?c 2) (and (neq ?c 3) (and (neq ?c 4) (and (neq ?c 5) (and (neq ?c 6) (neq ?c 7))))))))
=>
(printout t "Tienes que indicar un numero de columna: 1,2,3,4,5,6 o 7" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_check_columna_libre
(declare (salience 1))
?f <- (Juega J ?c)
(Tablero Juego 1 ?c ?X)
(test (neq ?X _))
=>
(printout t "Esa columna ya esta completa, tienes que jugar en otra" crlf)
(retract ?f)
(assert (Turno J))
)

(defrule juega_contrario_actualiza_estado
?f <- (Juega J ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X)
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego ?i ?c J))
)

(defrule juega_contrario_actualiza_estado_columna_vacia
?f <- (Juega J ?c)
?g <- (Tablero Juego 7 ?c _)
=>
(retract ?f ?g)
(assert (Turno M) (Tablero Juego 7 ?c J))
)


;;;;;;;;;;; ACTUALIZAR  ESTADO TRAS JUGADA DE CLISP ;;;;;;;;;;;;;;;;;;

(defrule juega_clisp_actualiza_estado
?f <- (Juega M ?c)
?g <- (Tablero Juego ?i ?c _)
(Tablero Juego ?j ?c ?X)
(test (= (+ ?i 1) ?j))
(test (neq ?X _))
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego ?i ?c M))
)

(defrule juega_clisp_actualiza_estado_columna_vacia
?f <- (Juega M ?c)
?g <- (Tablero Juego 7 ?c _)
=>
(retract ?f ?g)
(assert (Turno J) (Tablero Juego 7 ?c M))
)

;;;;;;;;;;; CLISP JUEGA SIN CRITERIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule clisp_juega_sin_criterio
(declare (salience -9999))
?f<- (Turno M)
(Tablero Juego ?i ?c _)
=>
(printout t "JUEGO en la columna (sin criterio) " ?c crlf)
(retract ?f)
(assert (Juega M ?c))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;  Comprobar si hay 4 en linea ;;;;;;;;;;;;;;;;;;;;;

(defrule cuatro_en_linea_horizontal
(declare (salience 9999))
(Tablero ?t ?i ?c1 ?jugador)
(Tablero ?t ?i ?c2 ?jugador)
(test (= (+ ?c1 1) ?c2))
(Tablero ?t ?i ?c3 ?jugador)
(test (= (+ ?c1 2) ?c3))
(Tablero ?t ?i ?c4 ?jugador)
(test (= (+ ?c1 3) ?c4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador horizontal ?i ?c1))
)

(defrule cuatro_en_linea_vertical
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i1 ?c ?jugador)
(Tablero ?t ?i2 ?c ?jugador)
(test (= (+ ?i1 1) ?i2))
(Tablero ?t ?i3 ?c  ?jugador)
(test (= (+ ?i1 2) ?i3))
(Tablero ?t ?i4 ?c  ?jugador)
(test (= (+ ?i1 3) ?i4))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador vertical ?i1 ?c))
)

(defrule cuatro_en_linea_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (+ ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (+ ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (+ ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_directa ?i ?c))
)

(defrule cuatro_en_linea_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Tablero ?t ?i ?c ?jugador)
(Tablero ?t ?i1 ?c1 ?jugador)
(test (= (+ ?i 1) ?i1))
(test (= (- ?c 1) ?c1))
(Tablero ?t ?i2 ?c2  ?jugador)
(test (= (+ ?i 2) ?i2))
(test (= (- ?c 2) ?c2))
(Tablero ?t ?i3 ?c3  ?jugador)
(test (= (+ ?i 3) ?i3))
(test (= (- ?c 3) ?c3))
(test (or (eq ?jugador M) (eq ?jugador J) ))
=>
(assert (Cuatro_en_linea ?t ?jugador diagonal_inversa ?i ?c))
)

;;;;;;;;;;;;;;;;;;;; DESCUBRE GANADOR
(defrule gana_fila
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador horizontal ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la fila " ?i crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_columna
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador vertical ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la columna " ?c crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_diagonal_directa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_directa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal que empieza la posicion " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
)

(defrule gana_diagonal_inversa
(declare (salience 9999))
?f <- (Turno ?X)
(Cuatro_en_linea Juego ?jugador diagonal_inversa ?i ?c)
=>
(printout t ?jugador " ha ganado pues tiene cuatro en linea en la diagonal hacia arriba que empieza la posicin " ?i " " ?c   crlf)
(retract ?f)
(assert (muestra_posicion))
)


;;;;;;;;;;;;;;;;;;;;;;;  DETECTAR EMPATE

(defrule empate
(declare (salience -9999))
(Turno ?X)
(Tablero Juego 1 1 M|J)
(Tablero Juego 1 2 M|J)
(Tablero Juego 1 3 M|J)
(Tablero Juego 1 4 M|J)
(Tablero Juego 1 5 M|J)
(Tablero Juego 1 6 M|J)
(Tablero Juego 1 7 M|J)
=>
(printout t "EMPATE! Se ha llegado al final del juego sin que nadie gane" crlf)
)

;;;;;;;;;;;;;;;;;;;;;; CONOCIMIENTO EXPERTO ;;;;;;;;;;
;;;;; ¡¡¡¡¡¡¡¡¡¡ Añadir codigo para que juege como vosotros jugariais !!!!!!!!!!!!

;;;;;;;;;;; CLISP JUEGA SIN CRITERIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule jugada_contrario
(declare (salience -9999))
?f<- (Turno J)
=>
(printout t " En que casilla quieres jugar: " crlf)
(retract ?f)
(assert (Juega J (read)))
)




; EJERCICIO A1
;

(defrule no_puede_jugarse_en
	; me da igual que jugador
	(Turno ?j)
	(Tablero Juego 1 ?c ?v)
	(test (neq ?v _))
	=>
	(assert (no_puede_jugarse ?c))
)

(defrule avisar_no_puede_jugarse
	; me da igual que jugador
	(Turno ?j)
	; este conocimiento no lo borramos, una vez se llena una columna, no se podrá
	; jugar en toda la partida en esa columna
	(no_puede_jugarse ?c)
	=>
	(printout t "No puede jugarse en : " ?c crlf)
)





; EJERCICIO A2
;
(defrule donde_caeria
	; primero comprobamos donde caeria
	(declare (salience 50))
	; me da igual el jugador
	(Turno ?j)
	(Tablero Juego ?f1 ?c ?v1)
	(Tablero Juego ?f2 ?c ?v2)
	;comprobamos si no hay piezas en toda la columna o si la de debajo tiene pieza
	(test (or (= ?f1 7) (= (+ ?f1 1) ?f2)))
	; en caso de que estemos donde no hay piezas en v1 caeria o en caso de que tengamos pieza
	; si la de debajo esta ocupada y v1 no, caeria en v1
	(test (or (and (= ?f1 7) (eq ?v1 _)) (and (eq ?v1 _) (neq ?v2 _) ) ))
	=>
	(assert (caeria ?f1 ?c))

)

(defrule avisar_donde_caeria
	; despuedes de comprobar donde caeria avisamos
	(declare (salience 5))
	; me da igual el jugador
	(Turno ?j)
	?x <- (caeria ?f ?c)
	=>
	(printout t "Si ponemos en " ?c " caeria en " ?f crlf)
	; una vez avisamos, lo quitamos de la base de conocimiento, en otro
	; turno será distinto
	(retract ?x)
)







; EJERCICIO A3
;
(defrule comprobar_tengo_dos_linea_horizontal
	(declare (salience 9))

	; me da igual quien tenga el turno
	(Turno ?j)
	(Tablero Juego ?f1 ?c1 ?v1)
	(Tablero Juego ?f2 ?c2 ?v2)
	; si estoy en la misma fila y si dos columnas son contiguas y sus valores son iguales
	(test (and (= ?f1 ?f2) (and (= ?c1 (+ ?c2 1)) (eq ?v1 ?v2) ) )  )
	(test (not (eq ?v1 _)))
	=>
	(assert (conectado_2 Juego h ?f1 ?c1 ?f2 ?c2 ?v1))
)

(defrule comprobar_tengo_dos_linea_vertical
	(declare (salience 9))

	; me da igual quien tenga el turno
	(Turno ?j)
	(Tablero Juego ?f1 ?c1 ?v1)
	(Tablero Juego ?f2 ?c2 ?v2)
	; si estoy en la misma fila y si dos columnas son contiguas y sus valores son iguales
	(test (and (= ?c1 ?c2) (and (= ?f1 (+ ?f2 1)) (eq ?v1 ?v2) ) )  )
	(test (not (eq ?v1 _)))
	=>
	(assert (conectado_2 Juego v ?f1 ?c1 ?f2 ?c2 ?v1))
)

(defrule comprobar_tengo_dos_linea_diagonal_directa
	(declare (salience 9))

	; me da igual quien tenga el turno
	(Turno ?j)
	(Tablero Juego ?f1 ?c1 ?v1)
	(Tablero Juego ?f2 ?c2 ?v2)
	; si es la fila siguiente, y la columna es una más abajo, formo diagonal directa
	(test (and (= ?c1 (+ ?c2 1)) (and (= ?f1 (+ ?f2 1)) (eq ?v1 ?v2)  ) )  )
	(test (not (eq ?v1 _)))
	=>
	(assert (conectado_2 Juego d1 ?f1 ?c1 ?f2 ?c2 ?v1))
)

(defrule comprobar_tengo_dos_linea_diagonal_inversa
	(declare (salience 9))

	; me da igual quien tenga el turno
	(Turno ?j1)
	(Tablero Juego ?f1 ?c1 ?v1)
	(Tablero Juego ?f2 ?c2 ?v2)
	; si la fila es la siguiente, y la columna es uno más arriba, es diagonal inversa
	(test (and (= ?c1 (- ?c2 1)) (and (= ?f1 (+ ?f2 1)) (eq ?v1 ?v2) ) )  )
	; comprobamos que no es _
	(test (not (eq ?v1 _)))
	=>
	(assert (conectado_2 Juego d2 ?f1 ?c1 ?f2 ?c2 ?v1))
)

(defrule avisar_tengo_dos_linea
	(declare (salience 2))
	(Turno ?j1)
	(conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	=>
	(printout t ?j " tiene dos fichas conectadas de forma " ?forma " en " ?f1 "," ?c1 " y " ?f2 "," ?c2   crlf)
)





; EJERCICIO A4
;
(defrule comprobar_tengo_3_linea_horizontal
	(declare (salience 8))
	(Turno ?j1)
	?x <- (conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	?y <- (conectado_2 Juego ?forma ?f3 ?c3 ?f4 ?c4 ?j)
	; estamos en la misma fila
	(test (and (= ?f2 ?f1) (and  (= ?f3 ?f4) (= ?f2 ?f3) ) ))

	; son contiguas entre si horizontalmente
	(test (and (= ?c1 (+ ?c2 1)) (= ?c3 (+ ?c4 1)  )))
	; la intermedia es la misma
	(test (= ?c2 ?c3))
	=>
	(assert (3_en_linea Juego h ?f1 ?c1 ?f4 ?c4 ?j))
	; si estan en 3 en raya ya sabemos que estan en 2 en raya, almacenar ese
	; conocimiento es redundante
	(retract ?x)
	(retract ?y)
)

(defrule comprobar_tengo_3_linea_vertical
	(declare (salience 8))
	(Turno ?j1)
	?x <- (conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	?y <- (conectado_2 Juego ?forma ?f3 ?c3 ?f4 ?c4 ?j)
	; estamos en la misma columna
	(test (and (= ?c2 ?c1) (and  (= ?c3 ?c4) (= ?c2 ?c3) ) ))

	; son contiguas entre si verticalmente
	(test (and (= ?f1 (+ ?f2 1)) (= ?f3 (+ ?f4 1)  )))
	; la intermedia es la misma
	(test (= ?f2 ?f3))
	=>
	(assert (3_en_linea Juego v ?f1 ?c1 ?f4 ?c4 ?j))
	; si estan en 3 en raya ya sabemos que estan en 2 en raya, almacenar ese
	; conocimiento es redundante
	(retract ?x)
	(retract ?y)
)

(defrule comprobar_tengo_3_linea_diagonal_principal
	(declare (salience 8))
	(Turno ?j1)
	?x <- (conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	?y <- (conectado_2 Juego ?forma ?f3 ?c3 ?f4 ?c4 ?j)
	; estamos en diagonal principal, y el intermedio es el mismo
	(test (and (= ?c1 (+ ?c2 1)) (and  (= ?c3 (+ ?c4 1)) (= ?c2 ?c3) ) ))

	; las filas son contiguas entre si verticalmente
	(test (and (= ?f1 (+ ?f2 1)) (= ?f3 (+ ?f4 1)  )))

	; la intermedia es la misma
	(test (= ?f2 ?f3))
	=>
	(assert (3_en_linea Juego d1 ?f1 ?c1 ?f4 ?c4 ?j))
	; si estan en 3 en raya ya sabemos que estan en 2 en raya, almacenar ese
	; conocimiento es redundante
	(retract ?x)
	(retract ?y)
)

(defrule comprobar_tengo_3_linea_diagonal_inversa
	(declare (salience 8))
	(Turno ?j1)
	?x <- (conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	?y <- (conectado_2 Juego ?forma ?f3 ?c3 ?f4 ?c4 ?j)
	; estamos en diagonal principal, y el intermedio es el mismo
	(test (and (= ?c1 (- ?c2 1)) (and  (= ?c3 (- ?c4 1)) (= ?c2 ?c3) ) ))

	; las filas son contiguas entre si verticalmente
	(test (and (= ?f1 (+ ?f2 1)) (= ?f3 (+ ?f4 1)  )))

	; la intermedia es la misma
	(test (= ?f2 ?f3))
	=>
	(assert (3_en_linea Juego d2 ?f1 ?c1 ?f4 ?c4 ?j))
	; si estan en 3 en raya ya sabemos que estan en 2 en raya, almacenar ese
	; conocimiento es redundante
	(retract ?x)
	(retract ?y)
)

(defrule avisar_tengo_tres_linea
	(declare (salience 3))
	(Turno ?j1)
	(3_en_linea Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	=>
	(printout t ?j " tiene tres fichas conectadas de forma " ?forma " en " ?f1 "," ?c1 " y " ?f2 "," ?c2   crlf)
)






; EJERCICIO A5
;
(defrule puedo_ganar_usando_3_linea_horizontal
	(declare (salience 7))
	(Turno ?j1)
	(3_en_linea Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	(Tablero Juego ?f3 ?c3 ?val)
	; estamos en la misma fila
	(test (and (= ?f2 ?f1) (= ?f3 ?f2) ))

	(test (or (= ?c1 (+ ?c3 1)) (or (= ?c2 (+ ?c3 1)) (or (= ?c1 (- ?c3 1)) (= ?c2 (- ?c3 1))  ) ) ))
	;(test (eq ?val _))
	(caeria ?f2 ?c3)
	=>
	(assert (ganaria ?j ?c3))
)

(defrule puedo_ganar_usando_2_linea_horizontal
	(declare (salience 7))
	(Turno ?j1)
	(conectado_2 Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	(Tablero Juego ?f3 ?c3 ?val1)
	(Tablero Juego ?f4 ?c4 ?val2)
	; estamos en la misma fila
	(test (and (= ?f2 ?f1) (and (= ?f3 ?f2) (= ?f3 ?f4)) ))

	; test la que esta puesta es del mismo valor que conectado_2
	(test (eq ?j ?val2))

	; comprobamos que estan alineadas
	(test
		; a un lado
		(or
			(and (= ?c3 (- ?c2 1)) (= ?c4 (- ?c3 1)) )

		; y al otro
			(and (= ?c3 (+ ?c1 1)) (= ?c4 (+ ?c3 1)) )
		)
	)

	;(test (eq ?val _))
	(caeria ?f3 ?c3)
	=>
	(assert (ganaria ?j ?c3))
)

(defrule puedo_ganar_usando_3_linea_vertical
	(declare (salience 7))
	(Turno ?j1)
	(3_en_linea Juego ?forma ?f1 ?c1 ?f2 ?c2 ?j)
	(Tablero Juego ?f3 ?c3 ?val)
	; estamos en la misma columna
	(test (and (= ?c2 ?c1) (= ?c3 ?c2) ))

	; aqui solo comprobamos si c3 + 1 = f1 o f2, ya que no podemos poner fichas por debajo
	(test (or (= ?f1 (+ ?f3 1)) (= ?f2 (+ ?f3 1))  ) )
	;(test (eq ?val _))
	(caeria ?f3 ?c3)
	=>
	(assert (ganaria ?j ?c3))
)

;en vertical solo puedes ganar si tienes 3, así que no es necesario hacer la regla de si
; tienes dos

(defrule avisar_puedo_ganar
	(declare (salience 3))
	(Turno ?j1)
	?x <- (ganaria ?j2 ?c)
	=>
	(printout t ?j2 " puede ganar si coloca en  " ?c   crlf)
	(retract ?x)
)
