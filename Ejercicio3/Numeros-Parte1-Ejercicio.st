!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:32'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:10'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:43'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:11'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:28'!
test10AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:42'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (twoFifth) * (fiveHalfs) ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:04:04'!
test14NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:05:06'!
test15NegationOfFraccionIsCorrect

	self assert: (Numero with: negativeOne over: two) equals: oneHalf negated! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:13:29'!
* aMultiplier 

		self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:18:49'!
+ anAdder 
	
	self subclassResponsibility. 
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:20:05'!
negated
	
	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'ip 9/27/2022 20:53:30'!
isNegative
	
	self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'ip 9/27/2022 20:55:32'!
isOne

	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'ip 9/27/2022 20:56:35'!
isZero

	self subclassResponsibility.! !


!Numero methodsFor: 'initialization' stamp: 'ip 9/27/2022 21:30:46'!
initializeWith: aValue
	
	value := aValue! !

!Numero methodsFor: 'initialization' stamp: 'ip 9/27/2022 21:30:50'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'printing' stamp: 'ip 9/27/2022 21:30:00'!
printOn: aStream
	
	self subclassResponsibility.! !


!Numero methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:28:35'!
= anObject

	self subclassResponsibility .! !

!Numero methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:25:42'!
hash
	
	self subclassResponsibility.! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:24:03'!
// aDivisor 
	
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:23:19'!
greatestCommonDivisorWith: anEntero 
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'ip 9/27/2022 20:58:03'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Enteros new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'ip 9/27/2022 20:58:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fracciones new initializeWith: numerator over: denominator! !


!classDefinition: #Enteros category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Enteros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Enteros methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:11:30'!
* aMultiplier
	(denominator = nil) ifTrue: [ ^self class with: value * aMultiplier integerValue ].
	self error: 'Tipo de número no soportado'! !

!Enteros methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:17:16'!
+ anAdder 
	(denominator = nil) ifTrue: [ ^self class with: value + anAdder integerValue ].
	self error: 'Tipo de número no soportado'! !

!Enteros methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:19:53'!
negated
	
	^self * (self class with: -1). ! !


!Enteros methodsFor: 'testing' stamp: 'ip 9/27/2022 20:53:52'!
isNegative
	
	^value < 0.! !

!Enteros methodsFor: 'testing' stamp: 'ip 9/27/2022 20:55:06'!
isOne
	
	^value = 1.! !

!Enteros methodsFor: 'testing' stamp: 'ip 9/27/2022 20:56:04'!
isZero
	
	^value = 0.! !


!Enteros methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:23:53'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.
! !

!Enteros methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:22:25'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).
		
	! !


!Enteros methodsFor: 'printing' stamp: 'ip 9/27/2022 21:29:37'!
printOn: aStream
	
	aStream print: value.
	! !


!Enteros methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:27:06'!
= anObject

	^(anObject isKindOf: self class)  ifTrue: [ value = anObject integerValue].! !

!Enteros methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:24:43'!
hash

	^value hash.! !


!classDefinition: #Fracciones category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fracciones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fracciones methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:12:54'!
* aMultiplier
	(value = nil) ifTrue: [ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
	self error: 'Tipo de número no soportado'! !

!Fracciones methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:18:29'!
+ anAdder
	(value = nil) ifTrue: [ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'! !

!Fracciones methodsFor: 'arithmetic operations' stamp: 'ip 9/27/2022 21:19:42'!
negated 
	
	^self class with: numerator * (self class with: -1) over: denominator! !


!Fracciones methodsFor: 'testing' stamp: 'ip 9/27/2022 20:53:43'!
isNegative

	^denominator < 0.! !

!Fracciones methodsFor: 'testing' stamp: 'ip 9/27/2022 20:55:26'!
isOne
	
	^false.! !

!Fracciones methodsFor: 'testing' stamp: 'ip 9/27/2022 20:55:58'!
isZero
	
	^false.! !


!Fracciones methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:28:01'!
= anObject
	^(anObject isKindOf: self class) ifTrue: [ (numerator * anObject denominator) = (denominator * anObject numerator) ].! !

!Fracciones methodsFor: 'comparing' stamp: 'ip 9/27/2022 21:25:00'!
hash

	^(numerator hash / denominator hash) hash.! !


!Fracciones methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:23:36'!
// aDivisor 
	
	self error: 'Tipo de número no soportado'! !

!Fracciones methodsFor: 'arithmetic operations - private' stamp: 'ip 9/27/2022 21:23:05'!
greatestCommonDivisorWith: anEntero 
	
	self error: 'Tipo de número no soportado'! !


!Fracciones methodsFor: 'printing' stamp: 'ip 9/27/2022 21:29:10'!
printOn: aStream
	
	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator.! !
