!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testingTools' stamp: 'ip 9/25/2022 19:27:30'!
checkAmountOfActive: expectedActiveAmount andSuspended: expectedSuspendedAmount andHasPaul: aClosure inBook: aCustomerBook
	self assert: expectedActiveAmount equals: aCustomerBook numberOfActiveCustomers.
	self assert: expectedSuspendedAmount equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: expectedActiveAmount + expectedSuspendedAmount equals: aCustomerBook numberOfCustomers.
	aClosure value.! !

!CustomerBookTest methodsFor: 'testingTools' stamp: 'ip 9/25/2022 18:46:04'!
expectedError: anErrorSignal withMessage: aMessage testingCondition: aTestClosure
	[ aMessage value. 
	self fail ]
		on: anErrorSignal 
		do: [	aTestClosure ]! !


!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:00:45'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:01:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook initializeWith: paulMcCartney.  
	
	self should: [customerBook removeCustomerNamed: paulMcCartney] notTakeMoreThan: 100 milliSeconds.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:03:44'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	self expectedError: Error 
		withMessage: [ customerBook addCustomerNamed: ''] 
		testingCondition: [:anError | 
				self assert: anError messageText = CustomerBook  				customerCanNotBeEmptyErrorMessage.
				self assert: customerBook isEmpty ]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:04:18'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := CustomerBook initializeWith: johnLennon.
	self expectedError: NotFound 
		withMessage: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		testingCondition: [ :anError | 
				self assert: (customerBook checkAmountOfCustomers: 1 
				andCustomerInclusion: 			johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:28:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook initializeWithSuspension: paulMcCartney.
	self checkAmountOfActive: 0 andSuspended: 1 andHasPaul: [self assert: (customerBook includesCustomerNamed: paulMcCartney)] inBook: customerBook.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:12:46'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook initializeWithSuspension: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:04:53'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook initializeWith: johnLennon .
	
	self expectedError: CantSuspend 
		withMessage: [customerBook suspendCustomerNamed: 'Ringo Starr'] 
		testingCondition: [ :anError | 
				self assert: (customerBook checkAmountOfCustomers: 1  				andCustomerInclusion: 			johnLennon)]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ip 9/25/2022 19:05:12'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.	
	customerBook := CustomerBook initializeWith: johnLennon.  
	customerBook suspendCustomerNamed: johnLennon.
	self expectedError: CantSuspend 
		withMessage: [customerBook suspendCustomerNamed: johnLennon] 
		testingCondition: [ :anError | 
				self assert: (customerBook checkAmountOfCustomers: 1  				andCustomerInclusion: 			johnLennon )]
	
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'ip 9/25/2022 18:00:07'!
checkAmountOfCustomers: anAmount andCustomerInclusion: aName
	^ self numberOfCustomers = anAmount & self includesCustomerNamed: aName.! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ip 9/25/2022 19:06:26'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !


!CustomerBook class methodsFor: 'as yet unclassified' stamp: 'ip 9/25/2022 17:33:52'!
initializeWith: aCustomer
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	^customerBook ! !

!CustomerBook class methodsFor: 'as yet unclassified' stamp: 'ip 9/25/2022 19:12:39'!
initializeWithSuspension: aNewCustomer 
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aNewCustomer.
	customerBook suspendCustomerNamed: aNewCustomer.
	^customerBook ! !
