!classDefinition: #MarsRoverTests category: 'Mars Rover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:50'!
test01creadoEnPosicionYDireccionCorrectas
	| rover gps|
	gps _ GPS apuntandoAlNorte.
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (gps).
	self assert: ((rover posicion = (0@0)) and: (rover gps = gps) and: (rover direccion = GPS stringDireccionNorte)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:50'!
test02rotarIzquierdaRotaBien
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlNorte).
	rover izquierda.
	self assert: (rover direccion = GPS stringDireccionOeste).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:50'!
test03rotarIzquierdaRotaBien
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlNorte).
	rover derecha.
	self assert: (rover direccion = GPS stringDireccionEste ).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:50'!
test04avanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlNorte).
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:48:15'!
test05avanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlSur).
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:38'!
test06giraDerechaYLuegoAvanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlEste).
	rover derecha.
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:59'!
test07giraDerechaYLuegoAvanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlOeste).
	rover derecha.
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:59'!
test08giraIzquierdaYLuegoAvanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlOeste).
	rover izquierda.
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:38'!
test09giraIzquierdaYLuegoAvanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS apuntandoAlEste).
	rover izquierda.
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:47:15'!
test10NoSePuedeCrearConGPSInvalido

	[ MarsRover creadoEn: (0@0) apuntandoHacia: GPS stringDireccionSur.
	self fail ]
		on: Error 
		do: [ :anError | 
				self assert: anError messageText = MarsRover errorGPSInvalido.]		.! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'tv 11/3/2022 19:48:15'!
test19NoSePuedeCrearConPosicionInvalida

	[ MarsRover creadoEn: 2 apuntandoHacia: GPS apuntandoAlSur.
	self fail ]
		on: Error 
		do: [ :anError | 
				self assert: anError messageText = MarsRover errorPosicionInvalida.]		.! !


!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:48:15'!
elComandoDeDesplazamiento: unComando esperaResultado: unaPosicionEsperada
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: GPS apuntandoAlSur.
	rover descifrarComandos: unComando.
	self assert: rover posicion = unaPosicionEsperada.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:48:15'!
elComandoDeRotacion: unComando esperaResultado: unaDireccionEsperada
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: GPS apuntandoAlSur.
	rover descifrarComandos: unComando.
	self assert: rover direccion = unaDireccionEsperada.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:48:15'!
elComandoInvalido: unComando dejaAlRoverEnLaPosicion: unaPosicionEsperada
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: GPS apuntandoAlSur.
	[ rover descifrarComandos: unComando.
	self fail ]
		on: Error 
		do: [ :anError | 
				self assert: anError messageText = MarsRover errorComandoInvalido.
				self assert: rover posicion = unaPosicionEsperada]		.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:48:15'!
test11UnComandoInvalidoDevuelveError
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: GPS apuntandoAlSur.
	[ rover descifrarComandos: '1'.
	self fail ]
		on: Error 
		do: [ :anError | 
				self assert: anError messageText = MarsRover errorComandoInvalido.]		.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:46:18'!
test12RotarALaIzquierdaNoDevuelveErrorYSeEjecutaCorrectamente

	self elComandoDeRotacion: 'l' esperaResultado: GPS stringDireccionEste.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:47:00'!
test13RotarALaDerechaNoDevuelveErrorYSeEjecutaCorrectamente
	
	self elComandoDeRotacion: 'r' esperaResultado: GPS stringDireccionOeste.! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 18:57:05'!
test14AvanzarNoDevuelveErrorYSeEjecutaCorrectamente
	
	self elComandoDeDesplazamiento: 'f' esperaResultado: (0@-1).! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 18:57:18'!
test15AtrasNoDevuelveErrorYSeEjecutaCorrectamente
	
	self elComandoDeDesplazamiento: 'b' esperaResultado: (0@1).! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:28:05'!
test16UnComandoVacioDevuelveError
			
	self elComandoInvalido: '' dejaAlRoverEnLaPosicion: (0@0).! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:29:55'!
test17UnComandoInvalidoEntreValidosEjecutaLosComandosPrevios
			
	self elComandoInvalido: 'flbfro' dejaAlRoverEnLaPosicion: (0@-1).! !

!MarsRoverTests methodsFor: 'testDeControles' stamp: 'tv 11/3/2022 19:30:25'!
test18UnComandoInvalidoDetieneLaEjecucion
	
	self elComandoInvalido: 'flbfrofbllb' dejaAlRoverEnLaPosicion: (0@-1).! !


!classDefinition: #GPS category: 'Mars Rover'!
Object subclass: #GPS
	instanceVariableNames: 'desplazamientoEnX desplazamientoEnY direccion izquierda derecha'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!GPS methodsFor: 'inicializacion' stamp: 'ip 11/3/2022 16:46:17'!
crearGPSConX: desplazamientoEjeX enY: desplazamientoEjeY apuntandoAl: direccionActual conIzquierda: direccionIzquierda yDerecha: direccionDerecha
	desplazamientoEnX _ desplazamientoEjeX .
	desplazamientoEnY _ desplazamientoEjeY .
	direccion _ direccionActual .
	izquierda _ direccionIzquierda .
	derecha _ direccionDerecha .! !


!GPS methodsFor: 'mensajesDeEstado' stamp: 'ip 11/3/2022 17:02:30'!
direccionActual
	^direccion .! !

!GPS methodsFor: 'mensajesDeEstado' stamp: 'ip 11/3/2022 17:18:25'!
factorDeDesplazamiento
	^(desplazamientoEnX @ desplazamientoEnY ).! !


!GPS methodsFor: 'rotaciones' stamp: 'ip 11/3/2022 17:12:46'!
rotarDerecha
	^derecha value.! !

!GPS methodsFor: 'rotaciones' stamp: 'ip 11/3/2022 17:07:42'!
rotarIzquierda
	^ izquierda value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GPS class' category: 'Mars Rover'!
GPS class
	instanceVariableNames: ''!

!GPS class methodsFor: 'creaciones' stamp: 'tv 11/3/2022 19:48:15'!
apuntandoAlEste
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 1 enY: 0 apuntandoAl: GPS stringDireccionEste conIzquierda: [GPS apuntandoAlNorte] yDerecha: [GPS apuntandoAlSur].! !

!GPS class methodsFor: 'creaciones' stamp: 'tv 11/3/2022 19:47:59'!
apuntandoAlNorte
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 0 enY: 1 apuntandoAl: GPS stringDireccionNorte conIzquierda: [GPS apuntandoAlOeste] yDerecha: [GPS apuntandoAlEste].! !

!GPS class methodsFor: 'creaciones' stamp: 'tv 11/3/2022 19:48:15'!
apuntandoAlOeste
	| gps |
	gps := GPS new.
	^gps crearGPSConX: -1 enY: 0 apuntandoAl: GPS stringDireccionOeste conIzquierda: [GPS apuntandoAlSur] yDerecha: [GPS apuntandoAlNorte].! !

!GPS class methodsFor: 'creaciones' stamp: 'tv 11/3/2022 19:48:14'!
apuntandoAlSur
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 0 enY: -1 apuntandoAl: GPS stringDireccionSur conIzquierda: [GPS apuntandoAlEste] yDerecha: [GPS apuntandoAlOeste].! !


!GPS class methodsFor: 'puntosCardinales' stamp: 'tv 11/3/2022 19:46:18'!
stringDireccionEste
	^'Este'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'tv 11/3/2022 19:46:35'!
stringDireccionNorte
	^'Norte'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'tv 11/3/2022 19:47:00'!
stringDireccionOeste
	^'Oeste'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'tv 11/3/2022 19:47:14'!
stringDireccionSur
	^'Sur'.! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicionActual gps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'creacion' stamp: 'ip 11/3/2022 16:49:13'!
inicializarEnPosicion: coordenadaActual conGPS: gpsCreado .
	posicionActual _ 	coordenadaActual .
	gps _ gpsCreado .! !


!MarsRover methodsFor: 'mensajesDeEstado' stamp: 'ip 11/3/2022 17:01:51'!
direccion
	^gps direccionActual.! !

!MarsRover methodsFor: 'mensajesDeEstado' stamp: 'ip 11/3/2022 17:01:37'!
gps
	^gps .! !

!MarsRover methodsFor: 'mensajesDeEstado' stamp: 'ip 11/3/2022 17:01:29'!
posicion
	^posicionActual .! !


!MarsRover methodsFor: 'rotacion' stamp: 'ip 11/3/2022 17:12:35'!
derecha
	gps _ gps rotarDerecha.! !

!MarsRover methodsFor: 'rotacion' stamp: 'ip 11/3/2022 17:07:57'!
izquierda
	gps _ gps rotarIzquierda.! !


!MarsRover methodsFor: 'despazamiento' stamp: 'ip 11/3/2022 17:20:03'!
atras
	posicionActual _ posicionActual - (gps factorDeDesplazamiento).! !

!MarsRover methodsFor: 'despazamiento' stamp: 'ip 11/3/2022 17:17:51'!
avanzar
	posicionActual _ posicionActual + (gps factorDeDesplazamiento).! !


!MarsRover methodsFor: 'controles' stamp: 'tv 11/3/2022 19:17:39'!
descifrarComandos: unStringConComandos
	| leido |
	leido _ false.
	unStringConComandos do: [ :unCaracter | 
		leido _ self lecturaDeCaracter: unCaracter.
		(leido) ifFalse: [^self error: MarsRover errorComandoInvalido].
		].
	(leido) ifFalse: [^self error: MarsRover errorComandoInvalido].
! !

!MarsRover methodsFor: 'controles' stamp: 'tv 11/3/2022 19:17:28'!
lecturaDeCaracter: unCaracter

	(unCaracter = $f) ifTrue: [self avanzar. ^true].
	(unCaracter = $b) ifTrue: [self atras. ^true].
	(unCaracter = $l) ifTrue: [self izquierda. ^true].
	(unCaracter = $r) ifTrue: [self derecha. ^true].
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'mensajes de error' stamp: 'tv 11/3/2022 18:22:05'!
errorComandoInvalido
 	^ 'Comando actual inválido'.! !

!MarsRover class methodsFor: 'mensajes de error' stamp: 'tv 11/3/2022 18:22:11'!
errorGPSInvalido
 	^ 'No se puede crear con GPS inválido'.! !

!MarsRover class methodsFor: 'mensajes de error' stamp: 'tv 11/3/2022 19:35:00'!
errorPosicionInvalida
	^'No se puede crear con posición inválida'.! !


!MarsRover class methodsFor: 'creacion' stamp: 'tv 11/3/2022 19:36:07'!
creadoEn: coordenadaActual apuntandoHacia: gpsCreado
	(gpsCreado isKindOf: GPS) ifFalse: [^self error: MarsRover errorGPSInvalido ].
	(coordenadaActual isKindOf: Point) ifFalse: [^self error: MarsRover errorPosicionInvalida].
	^(MarsRover new) inicializarEnPosicion: coordenadaActual conGPS: gpsCreado .! !
