!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'ip 10/11/2022 19:49:02'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ip 10/11/2022 21:20:02'!
test01ShouldNotFindWhenNotLinked
	| searcher |
	searcher := SentenceFinderByPrefix new. 
	self deny: (searcher find: 'ho').
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ip 10/11/2022 21:29:31'!
test02ShouldFindOne
	| searcher stack expected|
	stack := OOStack new.
	stack push: 'hola'.
	expected := OrderedCollection new.
	expected add: 'hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self assert: ((searcher find: 'ho') = expected ).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ip 10/11/2022 21:30:27'!
test03ShouldFindOneOutOfThree
	| searcher stack expected |
	stack := OOStack new.
	stack push: 'hola'.
	stack push: 'chau'.
	stack push: 'Hola'.
	expected := OrderedCollection new.
	expected add: 'hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self assert: ((searcher find: 'ho') = expected).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ip 10/11/2022 21:37:45'!
test03ShouldFindTwoOutOfThree
	| searcher stack expected |
	stack := OOStack new.
	stack push: 'hola'.
	stack push: 'chau'.
	stack push: 'holas'.
	expected := OrderedCollection new.
	expected add: 'hola'.
	expected add: 'holas'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self assert: ((searcher find: 'ho') = expected).
! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'statusMessages' stamp: 'ip 10/11/2022 19:55:41'!
isEmpty
	^elements isEmpty .! !

!OOStack methodsFor: 'statusMessages' stamp: 'ip 10/11/2022 19:55:41'!
size
	^elements size.! !


!OOStack methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 20:46:56'!
pop 
	elements := PossibleStackTypes with: elements collection.
	^elements pop.! !

!OOStack methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 20:01:24'!
push: anElementToBeStacked 
	^elements := elements push: anElementToBeStacked .! !

!OOStack methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 19:55:41'!
top
	^elements top .! !


!OOStack methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:01:43'!
initialize
	elements := Empty new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #PossibleStackTypes category: 'Stack-Exercise'!
Object subclass: #PossibleStackTypes
	instanceVariableNames: 'collectionOfElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PossibleStackTypes methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:41:58'!
initialize
	collectionOfElements := OrderedCollection new.! !

!PossibleStackTypes methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:44:38'!
initializeWith: aCollection
	collectionOfElements := OrderedCollection new.
	collectionOfElements addAll: aCollection .! !


!PossibleStackTypes methodsFor: 'statusMessages' stamp: 'ip 10/11/2022 20:46:44'!
collection
	^collectionOfElements.! !

!PossibleStackTypes methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:47:29'!
isEmpty
	self subclassResponsibility .! !

!PossibleStackTypes methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:47:33'!
size
	self subclassResponsibility .! !


!PossibleStackTypes methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:39:20'!
pop
	self subclassResponsibility .! !

!PossibleStackTypes methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 20:02:02'!
push: anElementToBeStacked 
	self subclassResponsibility.! !

!PossibleStackTypes methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:47:11'!
top
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PossibleStackTypes class' category: 'Stack-Exercise'!
PossibleStackTypes class
	instanceVariableNames: ''!

!PossibleStackTypes class methodsFor: 'private' stamp: 'ip 10/11/2022 20:36:15'!
stackIsOfThisSubclass: aCollection

	self subclassResponsibility .! !


!PossibleStackTypes class methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:41:04'!
with: aCollection 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	^(PossibleStackTypes subclasses detect: [ :aSubclass | aSubclass stackIsOfThisSubclass: aCollection ] ifNone: [  self error: 'aCollection debe ser una coleccion' ]) new initializeWith: aCollection.! !


!classDefinition: #Empty category: 'Stack-Exercise'!
PossibleStackTypes subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 21:57:57'!
pop
	self error: OOStack stackEmptyErrorDescription.! !

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:51:20'!
push: anElementToBeStacked
	| newStackType |
	newStackType := Using new.
	newStackType push: anElementToBeStacked .
	^newStackType.! !

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/13/2022 10:48:53'!
top
	self error: OOStack stackEmptyErrorDescription.! !


!Empty methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:48:03'!
isEmpty
	^true.! !

!Empty methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:48:00'!
size
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: 'Stack-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'private' stamp: 'ip 10/11/2022 20:37:31'!
stackIsOfThisSubclass: aCollection
	^aCollection isEmpty.! !


!classDefinition: #Using category: 'Stack-Exercise'!
PossibleStackTypes subclass: #Using
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Using methodsFor: 'statusMessages' stamp: 'ip 10/11/2022 19:56:09'!
isEmpty
	^collectionOfElements isEmpty ! !

!Using methodsFor: 'statusMessages' stamp: 'ip 10/11/2022 19:56:09'!
size
	^collectionOfElements size.! !


!Using methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 19:58:55'!
pop
	^collectionOfElements removeLast.! !

!Using methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 19:58:27'!
push: anElementToBeStacked 
	collectionOfElements addLast: anElementToBeStacked.
! !

!Using methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 20:21:05'!
top
	^collectionOfElements at: collectionOfElements size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Using class' category: 'Stack-Exercise'!
Using class
	instanceVariableNames: ''!

!Using class methodsFor: 'private' stamp: 'ip 10/11/2022 20:38:59'!
stackIsOfThisSubclass: aCollection
	^aCollection isEmpty not.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'aLinkedStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:56:49'!
stackLinking: anOOStackToBeLinked
	aLinkedStack := anOOStackToBeLinked .! !


!SentenceFinderByPrefix methodsFor: 'findOperation' stamp: 'ip 10/11/2022 21:36:03'!
find: aPrefixToLookFor
	|index failSafeCollection usefulElements|
	index := 0.
	(aLinkedStack isKindOf: OOStack ) ifFalse: [^false].
	failSafeCollection := OrderedCollection new.
	usefulElements := OrderedCollection new.
	[aLinkedStack isEmpty ] whileFalse: [failSafeCollection add: aLinkedStack pop. (failSafeCollection last beginsWith: aPrefixToLookFor) ifTrue: [usefulElements add: failSafeCollection last ]. index := index +1 ].
	[index > 0] whileTrue: [aLinkedStack push: failSafeCollection removeLast. index := index -1].
	^usefulElements .! !
