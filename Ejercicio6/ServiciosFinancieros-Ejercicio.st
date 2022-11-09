!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:13:28'!
test01PortfolioStartsWithZeroBalance

	self assert: (Portfolio new) balance = 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:22:31'!
test02PortfolioCanAddAReceptiveAccount
	| account portfolio |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account .
	self assert: portfolio elements isEmpty not. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:26:38'!
test03PortafolioWithBalancedAccountReturnsCorrectBalance
	| account portfolio |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio add: account.
	self assert: portfolio balance = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:24:28'!
test04PortfolioCanAddAnotherPortfolio
	| secondPortfolio portfolio |
	portfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	portfolio add: secondPortfolio.
	self assert: portfolio elements isEmpty not. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:30:42'!
test05PortfolioWithPortfolioIncludedReturnsCorrectBalance
	| account portfolio secondPortfolio |
	portfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	secondPortfolio add: account.
	portfolio add: secondPortfolio .
	self assert: portfolio balance = secondPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:33:27'!
test06PortfolioAddsUpBalanceCorrectly
	| account1 account2 account3  portfolio  |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 * peso on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 400 * peso on: account2.
	account3 := ReceptiveAccount new.
	Withdraw register: 100 * peso on: account3.
	portfolio add: account1 .
	portfolio add: account2 .
	portfolio add: account3 .
	self assert: portfolio balance = (400 *peso).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:36:48'!
test07EmptyPortfolioCantFindTransactions
	| portfolio  account transaction |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: (100*peso) on: account. 
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:41:23'!
test08IncludedTransactionCanBeFoundByPortfolio
	| portfolio account transaction |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: (100*peso) on: account. 
	portfolio add: account .
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:50:45'!
test09EmptyPortafolioReturnsEmptyTransactions
	| portfolio |
	portfolio := Portfolio new.
	self assert: (portfolio transactions isEmpty).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 20:57:11'!
test10PortafolioReturnsTransactionsCorrectly
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: (100*peso) on: account.
	Withdraw register: (100*peso) on: account. 
	portfolio add: account.
	self assert: (portfolio transactions = account transactions).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ip 11/8/2022 21:04:33'!
test11PortafolioWithPortfolioReturnsTransactionsCorrectly
	| portfolio account secondPortfolio |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	secondPortfolio := Portfolio new.
	Deposit register: (100*peso) on: account.
	Withdraw register: (100*peso) on: account. 
	secondPortfolio add: account.
	portfolio add: secondPortfolio.
	self assert: (portfolio transactions = secondPortfolio transactions).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ip 11/8/2022 19:49:28'!
atest08hayQueTener4o5Tests

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !

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


!Deposit methodsFor: 'value' stamp: 'ip 11/8/2022 19:48:28'!
balanceValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
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


!Withdraw methodsFor: 'value' stamp: 'ip 11/8/2022 19:48:28'!
balanceValue

	^ value negated ! !

!Withdraw methodsFor: 'value' stamp: 'ip 11/8/2022 19:43:34'!
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
