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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 15:55:05'!
test01ShouldNotFindWhenNotLinked
	| searcher |
	searcher := SentenceFinderByPrefix new. 
	self 
		should: [ searcher find: 'ho' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix finderErrorDescription equals: anError messageText ]
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 15:36:42'!
test04ShouldFindTwoOutOfThree
	| searcher stack expected |
	stack := OOStack new.
	stack push: 'hola'.
	stack push: 'chau'.
	stack push: 'holas'.
	expected := OrderedCollection new.
	expected add: 'holas'.
	expected add: 'hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self assert: ((searcher find: 'ho') = expected).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 15:41:46'!
test05ShouldDenyCaseSensitiveDifference
	| searcher stack |
	stack := OOStack new.
	stack push: 'Hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self assert: ((searcher find: 'ho') isEmpty).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 15:54:38'!
test06ShouldRejectEmptyPrefix
	| searcher stack |
	stack := OOStack new.
	stack push: 'Hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self 
		should: [ searcher find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix finderErrorDescription equals: anError messageText ]
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 18:01:19'!
test07ShouldNotModifyOriginalStackWhenFindingPrefix
	| searcher stack backUpStack |
	stack := OOStack new.
	stack push: 'Hola'.
	stack push: 'hola'.
	stack push: 'Holas'.
	backUpStack := stack postCopy.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack.
	searcher find: 'ho'.
	self assert: (backUpStack = stack).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 18:02:39'!
test08ShouldNotModifyOriginalStackWhenNotFindingPrefix
	| searcher stack backUpStack |
	stack := OOStack new.
	stack push: 'Hola'.
	stack push: 'Holaa'.
	stack push: 'Holas'.
	backUpStack := stack postCopy.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack.
	searcher find: 'ho'.
	self assert: (backUpStack = stack).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'tgrr 10/13/2022 18:01:54'!
test09ShouldRejectPrefixWithEmptySpace
	| searcher stack |
	stack := OOStack new.
	stack push: 'Hola'.
	searcher := SentenceFinderByPrefix new. 
	searcher stackLinking: stack .
	self 
		should: [ searcher find: 'Ho ' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix finderErrorDescription equals: anError messageText ]! !


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


!classDefinition: #PossibleLinkedStacksTypes category: 'Stack-Exercise'!
Object subclass: #PossibleLinkedStacksTypes
	instanceVariableNames: 'aLinkedStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PossibleLinkedStacksTypes methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:30:23'!
find: aPrefixToFind
	
	self subclassResponsibility .! !


!PossibleLinkedStacksTypes methodsFor: 'initialization' stamp: 'tgrr 10/13/2022 17:32:20'!
initializeWith: aStack
	
	aLinkedStack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PossibleLinkedStacksTypes class' category: 'Stack-Exercise'!
PossibleLinkedStacksTypes class
	instanceVariableNames: ''!

!PossibleLinkedStacksTypes class methodsFor: 'initialization' stamp: 'tgrr 10/13/2022 17:49:31'!
initialize: aLinkedStack

	^(PossibleLinkedStacksTypes subclasses detect: [ :aSubclass | aSubclass linkedStackIsOfThisSubclass: aLinkedStack] ifNone: [self error: self noSubclassError ]) new initializeWith: aLinkedStack. ! !


!PossibleLinkedStacksTypes class methodsFor: 'private' stamp: 'tgrr 10/13/2022 17:27:17'!
linkedStackIsOfThisSubclass: aLinkedStack

	self subclassResponsibility .! !


!PossibleLinkedStacksTypes class methodsFor: 'errors descriptions' stamp: 'tgrr 10/13/2022 17:48:12'!
noSubclassError
	
	^'There is no valid subclass.'.! !


!classDefinition: #InvalidLinkedStack category: 'Stack-Exercise'!
PossibleLinkedStacksTypes subclass: #InvalidLinkedStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!InvalidLinkedStack methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:33:56'!
find: aPrefixToFind

	^self error: SentenceFinderByPrefix finderErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidLinkedStack class' category: 'Stack-Exercise'!
InvalidLinkedStack class
	instanceVariableNames: ''!

!InvalidLinkedStack class methodsFor: 'private' stamp: 'tgrr 10/13/2022 17:26:12'!
linkedStackIsOfThisSubclass: aLinkedStack

	^(ValidLinkedStack linkedStackIsOfThisSubclass: aLinkedStack) not.! !


!classDefinition: #ValidLinkedStack category: 'Stack-Exercise'!
PossibleLinkedStacksTypes subclass: #ValidLinkedStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidLinkedStack methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:35:47'!
find: aPrefixToFind

	| prefix |
	prefix := PossiblePrefixesTypes initialize: aPrefixToFind.
	^prefix find: aPrefixToFind inStack: aLinkedStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidLinkedStack class' category: 'Stack-Exercise'!
ValidLinkedStack class
	instanceVariableNames: ''!

!ValidLinkedStack class methodsFor: 'private' stamp: 'tgrr 10/13/2022 17:26:31'!
linkedStackIsOfThisSubclass: aLinkedStack

	^aLinkedStack isKindOf: OOStack.! !


!classDefinition: #PossiblePrefixesTypes category: 'Stack-Exercise'!
Object subclass: #PossiblePrefixesTypes
	instanceVariableNames: 'aPrefixToSearch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PossiblePrefixesTypes methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:15:40'!
find: aPrefixToFind inStack: aLinkedStack

	self subclassResponsibility .! !


!PossiblePrefixesTypes methodsFor: 'initialization' stamp: 'tgrr 10/13/2022 16:54:14'!
initializeWith: aPrefix

	aPrefixToSearch := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PossiblePrefixesTypes class' category: 'Stack-Exercise'!
PossiblePrefixesTypes class
	instanceVariableNames: ''!

!PossiblePrefixesTypes class methodsFor: 'private' stamp: 'tgrr 10/13/2022 16:51:49'!
prefixIsOfThisSubclass: aPrefix

	self subclassResponsibility .! !


!PossiblePrefixesTypes class methodsFor: 'initialization' stamp: 'tgrr 10/13/2022 17:47:34'!
initialize: aPrefix

	^(PossiblePrefixesTypes subclasses detect: [ :aSubclass | aSubclass prefixIsOfThisSubclass: aPrefix] ifNone: [self error: self noSubclassError]) new initializeWith: aPrefix. ! !


!PossiblePrefixesTypes class methodsFor: 'errors descriptions' stamp: 'tgrr 10/13/2022 17:46:43'!
noSubclassError
	
	^'There is no valid subclass.'.! !


!classDefinition: #InvalidPrefix category: 'Stack-Exercise'!
PossiblePrefixesTypes subclass: #InvalidPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!InvalidPrefix methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:15:51'!
find: aPrefixToFind inStack: aLinkedStack

	^self error: SentenceFinderByPrefix finderErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidPrefix class' category: 'Stack-Exercise'!
InvalidPrefix class
	instanceVariableNames: ''!

!InvalidPrefix class methodsFor: 'private' stamp: 'tgrr 10/13/2022 17:12:36'!
prefixIsOfThisSubclass: aPrefix

	^(aPrefix findAnySubStr: ' ' startingAt: 0) <= (aPrefix size) or: (aPrefix isEmpty).! !


!classDefinition: #ValidPrefix category: 'Stack-Exercise'!
PossiblePrefixesTypes subclass: #ValidPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidPrefix methodsFor: 'searchFunctions' stamp: 'tgrr 10/13/2022 17:17:19'!
find: aPrefixToFind inStack: aLinkedStack

	| failSafeCollection usefulElements |
	failSafeCollection := OrderedCollection new.
	usefulElements := OrderedCollection new.
	[aLinkedStack isEmpty ] whileFalse: [ failSafeCollection add: aLinkedStack pop. (failSafeCollection last beginsWith: aPrefixToFind) ifTrue: 	[usefulElements add: failSafeCollection last ]]. 
	failSafeCollection reverseDo: [: anElement | aLinkedStack push: anElement].
	^usefulElements .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidPrefix class' category: 'Stack-Exercise'!
ValidPrefix class
	instanceVariableNames: ''!

!ValidPrefix class methodsFor: 'private' stamp: 'tgrr 10/13/2022 17:20:51'!
prefixIsOfThisSubclass: aPrefix

	^(InvalidPrefix prefixIsOfThisSubclass: aPrefix) not.! !


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


!PossibleStackTypes class methodsFor: 'initialization' stamp: 'tgrr 10/13/2022 17:53:40'!
with: aCollection 
	
	^(PossibleStackTypes subclasses detect: [ :aSubclass | aSubclass stackIsOfThisSubclass: aCollection ] ifNone: [ self error: self noSubclassError ]) new initializeWith: aCollection.! !


!PossibleStackTypes class methodsFor: 'errors descriptions' stamp: 'tgrr 10/13/2022 17:54:26'!
noSubclassError

	^'There is no valid subclass.'.! !


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


!Empty methodsFor: 'initialization' stamp: 'ip 10/11/2022 19:56:09'!
initialize
	collectionOfElements := OrderedCollection new.! !

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
	instanceVariableNames: 'aLinkedStack aPrefixToSearch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'ip 10/11/2022 20:56:49'!
stackLinking: anOOStackToBeLinked
	aLinkedStack := anOOStackToBeLinked .! !


!SentenceFinderByPrefix methodsFor: 'findOperation' stamp: 'tgrr 10/13/2022 17:39:12'!
find: aPrefixToFind
	| stack |
	stack := PossibleLinkedStacksTypes initialize: aLinkedStack .
	^stack find: aPrefixToFind .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errorDescriptions' stamp: 'tgrr 10/13/2022 15:51:10'!
finderErrorDescription

	^'Could not complete search'.! !
