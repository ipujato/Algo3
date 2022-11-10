!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'testPortfolio testAccount testPortfolio2 accountWith100Deposit testAccount2 depositFor100Peso'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:18:29'!
setUp
	testPortfolio := Portfolio new.
	testPortfolio2 := Portfolio new.
	testAccount := ReceptiveAccount new.
	testAccount2 := ReceptiveAccount new.
	accountWith100Deposit := ReceptiveAccount new.
	depositFor100Peso := Deposit register: 100*peso on: accountWith100Deposit .! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:08'!
test01PortfolioStartsWithZeroBalance

	self assert: testPortfolio balance = 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:51'!
test02PortfolioCanAddAReceptiveAccount
	testPortfolio add: testAccount .
	self assert: testPortfolio elements isEmpty not. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:08'!
test03PortafolioWithBalancedAccountReturnsCorrectBalance
	testPortfolio add: accountWith100Deposit .
	self assert: testPortfolio balance = accountWith100Deposit balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:43'!
test04PortfolioCanAddAnotherPortfolio
	testPortfolio add: testPortfolio2 .
	self assert: testPortfolio elements isEmpty not. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:43'!
test05PortfolioWithPortfolioIncludedReturnsCorrectBalance
	testPortfolio2 add: accountWith100Deposit .
	testPortfolio add: testPortfolio2 .
	self assert: testPortfolio balance = testPortfolio2 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:18:30'!
test06PortfolioAddsUpBalanceCorrectly
	Deposit register: 400 * peso on: testAccount.
	Withdraw register: 100 * peso on: testAccount2.
	testPortfolio add: accountWith100Deposit .
	testPortfolio add: testAccount .
	testPortfolio add: testAccount2 .
	self assert: testPortfolio balance = (400 *peso).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:08'!
test07EmptyPortfolioCantFindTransactions
	self deny: (testPortfolio hasRegistered: depositFor100Peso).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:08'!
test08IncludedTransactionCanBeFoundByPortfolio
	testPortfolio add: accountWith100Deposit .
	self assert: (testPortfolio hasRegistered: depositFor100Peso).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:08'!
test09EmptyPortafolioReturnsEmptyTransactions
	self assert: (testPortfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:51'!
test10PortafolioReturnsTransactionsCorrectly
	Deposit register: (100*peso) on: testAccount.
	Withdraw register: (100*peso) on: testAccount. 
	testPortfolio add: testAccount.
	self assert: (testPortfolio transactions = testAccount transactions).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:17:43'!
test11PortafolioWithPortfolioReturnsTransactionsCorrectly
	Withdraw register: (100*peso) on: accountWith100Deposit . 
	testPortfolio2 add: accountWith100Deposit .
	testPortfolio add: testPortfolio2.
	self assert: (testPortfolio transactions = testPortfolio2 transactions).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'testReceptiveAccount testReceptiveAccount2 a100PesoTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:25:18'!
setUp
	testReceptiveAccount _ ReceptiveAccount new.
	testReceptiveAccount2 _ ReceptiveAccount new.
	a100PesoTransfer _ Transference register: 100*peso on: testReceptiveAccount from: testReceptiveAccount2.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:25:18'!
test01MoneyFromOneAccountToAnotherIsMovedCorrectly
	self assert: testReceptiveAccount balance = (100*peso).
	self assert: testReceptiveAccount2 balance = (-100*peso).! !

!TransferenceTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:24:35'!
test02ATransferKnowsItsValue
	| transfer |
	transfer _ a100PesoTransfer .
	self assert: transfer value = (100*peso).
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:24:35'!
test03DepositLegKnowsWithdraw
	| leg |
	leg _ a100PesoTransfer depositLeg.
	self assert: (testReceptiveAccount2 hasRegistered: (leg relatedTransaction)).
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'ip 11/10/2022 18:25:18'!
test04ExtractionLegKnowsDeposit
	| leg |
	leg _ a100PesoTransfer extractionLeg.
	self assert: (testReceptiveAccount hasRegistered: (leg relatedTransaction)).
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ip 11/8/2022 19:48:28'!
balanceValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'main protocol' stamp: 'ip 11/8/2022 19:48:28'!
balanceValue

	^ value! !

!Deposit methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'ip 11/8/2022 19:43:12'!
initializeFor: aValue

	value := aValue .! !


!Withdraw methodsFor: 'main protocol' stamp: 'ip 11/8/2022 19:48:28'!
balanceValue

	^ value negated ! !

!Withdraw methodsFor: 'main protocol' stamp: 'ip 11/8/2022 19:43:34'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'includedElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/8/2022 20:25:18'!
add: aRecievedElement 
	includedElements add: aRecievedElement .! !

!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/8/2022 20:19:29'!
balance
	^ includedElements sum: [ :anElement | anElement balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/8/2022 20:22:51'!
elements
	^ includedElements copy.! !

!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/8/2022 20:44:40'!
hasRegistered: aTransaction 
	includedElements do: [ :anElement | (anElement hasRegistered: aTransaction) ifTrue: [^true]].
	^false.! !

!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/8/2022 21:00:41'!
transactions
	| totalTransactions |
	totalTransactions _ OrderedCollection new.
	includedElements do: [ :anElement | totalTransactions addAllFirst: anElement transactions ].
	^totalTransactions.
	! !


!Portfolio methodsFor: 'initialization' stamp: 'ip 11/8/2022 20:12:27'!
initialize
	
	includedElements := OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ip 11/8/2022 19:48:28'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceValue ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'main protocol' stamp: 'ip 11/10/2022 17:50:51'!
depositLeg
	^depositLeg! !

!Transference methodsFor: 'main protocol' stamp: 'ip 11/10/2022 17:43:49'!
extractionLeg
	^extractionLeg ! !

!Transference methodsFor: 'main protocol' stamp: 'ip 11/10/2022 17:24:33'!
value
	^ value! !


!Transference methodsFor: 'initialization' stamp: 'ip 11/10/2022 18:00:52'!
initializeWith: anAmountOfMoney on: receptorAccount from: originAccount
	extractionLeg _ ExtractionLeg register: anAmountOfMoney on: receptorAccount from: originAccount .
	depositLeg _ DepositLeg register: anAmountOfMoney on: originAccount from: originAccount .
	value _ anAmountOfMoney .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instanceCreation' stamp: 'ip 11/10/2022 17:26:10'!
register: anAmountOfMoney on: receptorAccount from: originAccount
	|transfer |
	transfer _ Transference new.
	^transfer initializeWith: anAmountOfMoney on: receptorAccount from: originAccount .! !


!classDefinition: #DepositLeg category: 'ServiciosFinancieros-Ejercicio'!
Transference subclass: #DepositLeg
	instanceVariableNames: 'withdrawForTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLeg methodsFor: 'initialization' stamp: 'ip 11/10/2022 17:47:46'!
initializeWith: anAmountOfMoney on: receptorAccount from: originAccount
	withdrawForTransfer _ Withdraw register: anAmountOfMoney on: originAccount.
	! !


!DepositLeg methodsFor: 'main protocol' stamp: 'ip 11/10/2022 17:49:13'!
relatedTransaction
	^withdrawForTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'ServiciosFinancieros-Ejercicio'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'instanceCreation' stamp: 'ip 11/10/2022 17:46:27'!
register: anAmountOfMoney on: receptorAccount from: originAccount
	| leg |
	leg _ DepositLeg new.
	^leg initializeWith: anAmountOfMoney on: receptorAccount from: originAccount .! !


!classDefinition: #ExtractionLeg category: 'ServiciosFinancieros-Ejercicio'!
Transference subclass: #ExtractionLeg
	instanceVariableNames: 'depositForTransfer depositAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ExtractionLeg methodsFor: 'initialization' stamp: 'ip 11/10/2022 17:57:31'!
initializeWith: anAmountOfMoney on: receptorAccount from: originAccount
	depositForTransfer _ Deposit register: anAmountOfMoney on: receptorAccount.! !


!ExtractionLeg methodsFor: 'main protocol' stamp: 'ip 11/10/2022 17:44:43'!
relatedTransaction
	^depositForTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractionLeg class' category: 'ServiciosFinancieros-Ejercicio'!
ExtractionLeg class
	instanceVariableNames: ''!

!ExtractionLeg class methodsFor: 'instanceCreation' stamp: 'ip 11/10/2022 17:38:36'!
register: anAmountOfMoney on: receptorAccount from: originAccount
	| leg |
	leg _ ExtractionLeg new.
	^leg initializeWith: anAmountOfMoney on: receptorAccount from: originAccount .! !
