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


!OOStack methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 20:01:18'!
pop 
	(elements isEmpty) ifTrue: [elements := Empty new].
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

!PossibleStackTypes methodsFor: 'initialization' stamp: 'ip 10/10/2022 17:37:44'!
initialize
	self subclassResponsibility .! !


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


!classDefinition: #Empty category: 'Stack-Exercise'!
PossibleStackTypes subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:40:05'!
pop
	^self error: 'Stack is empty'.! !

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:51:20'!
push: anElementToBeStacked
	| newStackType |
	newStackType := Using new.
	newStackType push: anElementToBeStacked .
	^newStackType.! !

!Empty methodsFor: 'stackFunctions' stamp: 'ip 10/10/2022 17:45:51'!
top
	^self error: 'Stack is empty' ! !


!Empty methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:48:03'!
isEmpty
	^true.! !

!Empty methodsFor: 'statusMessages' stamp: 'ip 10/10/2022 17:48:00'!
size
	^0.! !


!Empty methodsFor: 'initialization' stamp: 'ip 10/11/2022 19:56:09'!
initialize
	collectionOfElements := OrderedCollection new.! !


!classDefinition: #Using category: 'Stack-Exercise'!
PossibleStackTypes subclass: #Using
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Using methodsFor: 'initialization' stamp: 'ip 10/11/2022 19:56:09'!
initialize
	collectionOfElements := OrderedCollection new.! !


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

!Using methodsFor: 'stackFunctions' stamp: 'ip 10/11/2022 19:56:09'!
top
	| elementToCollect |
	collectionOfElements do:[ :anElementOnCollection | elementToCollect := anElementOnCollection]. 
	^elementToCollect .! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
