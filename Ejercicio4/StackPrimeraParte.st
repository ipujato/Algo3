!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'ip 10/4/2022 21:11:41'!
test01StackShouldBeEmptyWhenCreated

	| stack |

	stack := Stack new.

	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'ip 10/5/2022 14:50:59'!
test02StackAddsAnElementCorrectly

	| stack |

	stack := Stack new.
	stack push: #uno.
	self assert: stack size = 1.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'ip 10/10/2022 15:27:26'!
test03StackRemovesAnElementCorrectly
	| erasedElemento stack |

	stack := Stack new.
	stack push: #uno.
	stack push: #dos.
	erasedElemento := stack pop.
	self assert: stack size = 1 & erasedElemento = #dos		.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'ip 10/10/2022 15:29:50'!
test04StackGetsLastElementCorrectly
	| stack lastElemento |

	stack := Stack new.
	stack push: #uno.
	stack push: #dos.
	lastElemento := stack last.
	self assert: stack size = 2 & lastElemento = #dos		.! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'as yet unclassified' stamp: 'ip 10/5/2022 14:42:40'!
initialize
	collection := Bag new.! !


!Stack methodsFor: 'status messages' stamp: 'ip 10/10/2022 15:15:35'!
isEmpty
	^self size = 0.! !

!Stack methodsFor: 'status messages' stamp: 'ip 10/10/2022 15:15:42'!
size

	^collection size.! !


!Stack methodsFor: 'stack functions' stamp: 'ip 10/10/2022 15:30:53'!
last
	| elementToCollect |
	collection do:[ :anElementOnCollection | elementToCollect := anElementOnCollection]. 
	^elementToCollect .
	! !

!Stack methodsFor: 'stack functions' stamp: 'ip 10/10/2022 15:31:36'!
pop
	
	^collection remove: self last ifAbsent: [^'Salio mal'].

	! !

!Stack methodsFor: 'stack functions' stamp: 'ip 10/5/2022 14:50:41'!
push: anElementToBeAdded
	^collection add: anElementToBeAdded.! !
