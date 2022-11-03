!classDefinition: #MarsRoverTests category: 'Mars Rover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:30:23'!
atest10Error
	"MarsRover creadoEn: (0@0) apuntandoHacia: GPS direccionSur."
	self checkAnExpectedError: Error 
		withMessage: [ MarsRover creadoEn: (0@0) apuntandoHacia: GPS direccionSur.] 
		andTestingCondition: [:anError | 
				self assert: anError messageText = MarsRover errorGPSInvalido.].! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:03:17'!
test01creadoEnPosicionYDireccionCorrectas
	| rover gps|
	gps _ GPS norte.
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (gps).
	self assert: ((rover posicion = (0@0)) and: (rover gps = gps) and: (rover direccion = GPS direccionNorte)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:15:28'!
test02rotarIzquierdaRotaBien
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS norte).
	rover izquierda.
	self assert: (rover direccion = GPS direccionOeste).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:15:39'!
test03rotarIzquierdaRotaBien
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS norte).
	rover derecha.
	self assert: (rover direccion = GPS direccionEste ).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:18:54'!
test04avanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS norte).
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:19:23'!
test05avanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS sur).
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:23:09'!
test06giraDerechaYLuegoAvanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS este).
	rover derecha.
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:23:20'!
test07giraDerechaYLuegoAvanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS oeste).
	rover derecha.
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:23:38'!
test08giraIzquierdaYLuegoAvanzaHaciaAtrasCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS oeste).
	rover izquierda.
	rover atras.
	self assert: (rover posicion = (0@1)).! !

!MarsRoverTests methodsFor: 'testDeMovilidad' stamp: 'ip 11/3/2022 17:24:14'!
test09giraIzquierdaYLuegoAvanzaHaciaAdelanteCorrectamente
	| rover |
	rover _ MarsRover creadoEn: (0@0) apuntandoHacia: (GPS este).
	rover izquierda.
	rover avanzar.
	self assert: (rover posicion = (0@1)).! !


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

!GPS class methodsFor: 'creaciones' stamp: 'ip 11/3/2022 17:08:39'!
este
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 1 enY: 0 apuntandoAl: GPS direccionEste conIzquierda: [GPS norte] yDerecha: [GPS sur].! !

!GPS class methodsFor: 'creaciones' stamp: 'ip 11/3/2022 17:10:33'!
norte
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 0 enY: 1 apuntandoAl: GPS direccionNorte conIzquierda: [GPS oeste] yDerecha: [GPS este].! !

!GPS class methodsFor: 'creaciones' stamp: 'ip 11/3/2022 17:21:00'!
oeste
	| gps |
	gps := GPS new.
	^gps crearGPSConX: -1 enY: 0 apuntandoAl: GPS direccionOeste conIzquierda: [GPS sur] yDerecha: [GPS norte].! !

!GPS class methodsFor: 'creaciones' stamp: 'ip 11/3/2022 17:21:07'!
sur
	| gps |
	gps := GPS new.
	^gps crearGPSConX: 0 enY: -1 apuntandoAl: GPS direccionSur conIzquierda: [GPS este] yDerecha: [GPS oeste].! !


!GPS class methodsFor: 'puntosCardinales' stamp: 'ip 11/3/2022 16:59:01'!
direccionEste
	^'Este'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'ip 11/3/2022 16:59:08'!
direccionNorte
	^'Norte'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'ip 11/3/2022 16:59:28'!
direccionOeste
	^'Oeste'.! !

!GPS class methodsFor: 'puntosCardinales' stamp: 'ip 11/3/2022 16:59:14'!
direccionSur
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'ip 11/3/2022 17:28:54'!
creadoEn: coordenadaActual apuntandoHacia: gpsCreado
	(gpsCreado isKindOf: GPS) ifFalse: [^self error: MarsRover errorGPSInvalido ].
	^(MarsRover new) inicializarEnPosicion: coordenadaActual conGPS: gpsCreado .! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'ip 11/3/2022 17:27:51'!
errorGPSInvalido
 	^ 'No se puede crear con GPS invalio'.! !
