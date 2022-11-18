!classDefinition: #AccountReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:17:50'!
test01CantDoASummaryOfSomethingThatIsNotAnAccount
	 |anAccountSummary|
	anAccountSummary _ AccountReporter for: OrderedCollection new.
	
	"self assert: 'No puedo generar este reporte' equals: anAccountSummary accountSummary."
	self 
		should: [ anAccountSummary accountSummary ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: AccountReporter InvalidAccountAssigned equals: anError messageText.
			]! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:17:56'!
test02AnEmptyAccountHasASummaryWithOnlyBalance
	| anAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: (OrderedCollection with: 'Balance = 0 * pesos') equals: anAccountSummary accountSummary.! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:14:38'!
test03AUsedAccountSummaryHasItsOnlyWithdraw
	| anAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	Withdraw register: 100*peso on: anAccount .
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: (OrderedCollection with: 'Extracción por 100 * pesos' with: 'Balance = -100 * pesos') equals: anAccountSummary accountSummary.! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:13:50'!
test04AUsedAccountSummaryHasItsOnlyMadeTransfer
	| anAccount aSecondAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Transfer amount: 100 * peso from: anAccount to: aSecondAccount.
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 100 * pesos' with: 'Balance = -100 * pesos') equals: anAccountSummary accountSummary.! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:14:00'!
test05AUsedAccountSummaryHasItsOnlyRecivedTransfer
	| anAccount aSecondAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Transfer amount: 100 * peso from: anAccount to: aSecondAccount.
	anAccountSummary _ AccountReporter for: aSecondAccount .
	
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100 * pesos' with: 'Balance = 100 * pesos') equals: anAccountSummary accountSummary.! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:18:06'!
test06AUsedAccountSummaryHasItsOnlyDeposit
	| anAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount .
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: (OrderedCollection with: 'Depósito por 100 * pesos' with: 'Balance = 100 * pesos') equals: anAccountSummary accountSummary.! !

!AccountReportTest methodsFor: 'account summary test' stamp: 'ip 11/17/2022 12:18:16'!
test07AUsedAccountSummaryIsCorrect
	| anAccount aSecondAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount .
	Withdraw register: 10*peso on: anAccount .
	Transfer amount: 10 * peso from: anAccount to: aSecondAccount.
	Transfer amount: 20 * peso from: aSecondAccount to: anAccount .
	anAccountSummary _ AccountReporter for: anAccount .
	
	self assert: (OrderedCollection with: 'Depósito por 100 * pesos' with: 'Extracción por 10 * pesos' with: 'Salida por transferencia de 10 * pesos' with: 'Entrada por transferencia de 20 * pesos' with: 'Balance = 100 * pesos') equals: anAccountSummary accountSummary.! !


!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:17:23'!
test08CantDoANetTransferReportOfSomethingThatIsNotAnAccount
	 |anAccountSummary|
	anAccountSummary _ AccountReporter for: OrderedCollection new.
	self 
		should: [ anAccountSummary netTransferReport ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: AccountReporter InvalidAccountAssigned equals: anError messageText.
			]! !

!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:29:56'!
test09AnEmptyAccountHasAZeroNetReport
	| anAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: 'Net Transfer Balance = 0 * pesos' equals: anAccountSummary netTransferReport .! !

!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:29:45'!
test10AnAccountWithNoTransfersHasAZeroNetReport
	| anAccount anAccountSummary |
	anAccount _ ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount .
	Withdraw register: 50 * peso on: anAccount .
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: 'Net Transfer Balance = 0 * pesos' equals: anAccountSummary netTransferReport .! !

!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:34:27'!
test11AnAccountWithARecivedTransfersHasANetReport
	| anAccount anAccountSummary aSecondAccount|
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Transfer amount: 10 * peso from: anAccount to: aSecondAccount.
	anAccountSummary _ AccountReporter for: aSecondAccount .
	
	self assert: 'Net Transfer Balance = 10 * pesos' equals: anAccountSummary netTransferReport .! !

!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:34:19'!
test12AnAccountWithAnOutgoingTransfersHasANetReport
	| anAccount anAccountSummary aSecondAccount|
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Transfer amount: 10 * peso from: anAccount to: aSecondAccount.
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: 'Net Transfer Balance = -10 * pesos' equals: anAccountSummary netTransferReport .! !

!AccountReportTest methodsFor: 'net transfer report test' stamp: 'ip 11/17/2022 12:37:55'!
test13NetReportIsCorrectForMultipleTransferAccount
	| anAccount anAccountSummary aSecondAccount|
	anAccount _ ReceptiveAccount new.
	aSecondAccount _ ReceptiveAccount new.
	Transfer amount: 100 * peso from: aSecondAccount to: anAccount.
	Transfer amount: 10 * peso from: anAccount to: aSecondAccount.
	anAccountSummary _ AccountReporter for: anAccount.
	
	self assert: 'Net Transfer Balance = 90 * pesos' equals: anAccountSummary netTransferReport .! !


!classDefinition: #PortfolioReporterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioReporterTest
	instanceVariableNames: 'associatedAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioReporterTest methodsFor: 'tree printer test' stamp: 'ip 11/17/2022 20:18:24'!
test01AnIndividualPortfolioPrintsItsName
	self assert: (OrderedCollection with: 'Portfolio de la familia') equals: ((PortfolioReporter for: (Portfolio named: 'Portfolio de la familia')) treePrinter).! !

!PortfolioReporterTest methodsFor: 'tree printer test' stamp: 'ip 11/17/2022 20:18:30'!
test02AnIndividualPortfolioPrintsItsSonIndented
	| account portfolio |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	account _ ReceptiveAccount named: 'Cuenta mia'.
	portfolio add: account . 
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: '#Cuenta mia') equals: ((PortfolioReporter for: portfolio) treePrinter).! !

!PortfolioReporterTest methodsFor: 'tree printer test' stamp: 'ip 11/17/2022 20:18:35'!
test03ADoubleComposedPortfolioHasDoubleIndetation
	| account portfolio portfolio2 |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	portfolio2 _ Portfolio named: 'Portfolio de hijo'.
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	portfolio add: portfolio2.
	portfolio2 add: account . 
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: '#Portfolio de hijo' with: '##Cuenta de Juan') equals: ((PortfolioReporter for: portfolio) treePrinter).! !

!PortfolioReporterTest methodsFor: 'tree printer test' stamp: 'ip 11/17/2022 20:19:25'!
test04DoubleComposedWithDoubleAccountPrintsCorrectly
	| portfolio portfolio2 expectedCollection |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	portfolio2 _ Portfolio named: 'Portfolio de hijos'.
	portfolio add: (ReceptiveAccount named: 'Cuenta mia').
	portfolio add: portfolio2.
	portfolio2 add:  (ReceptiveAccount named: 'Cuenta de Juan') . 
	portfolio2 add:  (ReceptiveAccount named: 'Cuenta de Angeles') . 
	expectedCollection _ OrderedCollection with: 'Portfolio de la familia' with: '#Cuenta mia' with: '#Portfolio de hijos' with: '##Cuenta de Juan' with: '##Cuenta de Angeles'.
	self assert: expectedCollection equals: (PortfolioReporter for: portfolio) treePrinter.! !


!PortfolioReporterTest methodsFor: 'detailed tree printer test' stamp: 'ip 11/17/2022 20:47:56'!
test05AnIndividualPortfolioPrintsItsNameWithBalance
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: '#Balance = 0 * pesos') equals: ((PortfolioReporter for: (Portfolio named: 'Portfolio de la familia')) detailedTreePrinter).! !

!PortfolioReporterTest methodsFor: 'detailed tree printer test' stamp: 'ip 11/17/2022 20:48:08'!
test06AnIndividualPortfolioPrintsItsSonIndentedWithBothBalances
	| account portfolio |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	account _ ReceptiveAccount named: 'Cuenta mia'.
	Deposit register: 10 * peso on: account .
	portfolio add: account . 
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: '#Cuenta mia' with: '##Depósito por 10 * pesos' with: '##Balance = 10 * pesos' with: '#Balance = 10 * pesos') equals: ((PortfolioReporter for: portfolio) detailedTreePrinter).! !

!PortfolioReporterTest methodsFor: 'detailed tree printer test' stamp: 'ip 11/17/2022 20:52:41'!
test07ADoubleComposedPortfolioHasDoubleIdentationAndBalance
	| account portfolio portfolio2 expectedResult |
	portfolio _ Portfolio named: 'Portfolio de la familia'.
	portfolio2 _ Portfolio named: 'Portfolio de hijo'.
	account _ ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 10 * peso on: account .
	portfolio add: portfolio2.
	portfolio2 add: account . 
	expectedResult _ OrderedCollection with: 'Portfolio de la familia' with: '#Portfolio de hijo' with: '##Cuenta de Juan' with: '###Depósito por 10 * pesos' with: '###Balance = 10 * pesos' with: '##Balance = 10 * pesos'.
	expectedResult add: '#Balance = 10 * pesos'.
	self assert: expectedResult equals: ((PortfolioReporter for: portfolio) detailedTreePrinter).! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'ip 11/17/2022 20:37:56'!
detailedNameWithIndetation: accordingIndentation on: anOrderedCollection
	self subclassResponsibility .! !

!Account methodsFor: 'reports' stamp: 'ip 11/17/2022 20:38:09'!
name
	self subclassResponsibility .! !

!Account methodsFor: 'reports' stamp: 'ip 11/17/2022 20:38:21'!
nameWithIndetation: accorddingIndentation on: anOrderedCollection
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents portfolioName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ip 11/17/2022 19:47:42'!
intializeNamed: aName
	portfolioName := aName .
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'ip 11/17/2022 10:53:47'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0*peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'ip 11/17/2022 19:34:44'!
accounts 

	^ accounts copy! !

!Portfolio methodsFor: 'reports' stamp: 'ip 11/17/2022 21:04:04'!
detailedNameWithIndetation: accorddingIndentation on: anOrderedCollection 
	anOrderedCollection add: (accorddingIndentation , portfolioName 	).
	accounts do: [ :anAccount | anAccount detailedNameWithIndetation: (accorddingIndentation ,'#') on: anOrderedCollection ].
	anOrderedCollection add: accorddingIndentation, '#Balance = ', (self balance asString ).! !

!Portfolio methodsFor: 'reports' stamp: 'ip 11/17/2022 19:47:42'!
name
	^portfolioName ! !

!Portfolio methodsFor: 'reports' stamp: 'ip 11/17/2022 19:56:54'!
nameWithIndetation: accorddingIndentation on: anOrderedCollection 
	anOrderedCollection add: (accorddingIndentation , portfolioName 	).
	accounts do: [ :anAccount | anAccount nameWithIndetation: (accorddingIndentation ,'#') on: anOrderedCollection ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ip 11/17/2022 12:51:03'!
named: aName
	^((Portfolio new) intializeNamed: aName).! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ip 11/17/2022 19:47:30'!
intializeNamed: aName

	super initialize.
	transactions := OrderedCollection new.
	accountName := aName! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ip 11/17/2022 10:54:07'!
balance

	^transactions 
		inject: 0*peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'ip 11/17/2022 20:58:14'!
detailedNameWithIndetation: accordingIndentation on: anOrderedCollection
	anOrderedCollection add: (accordingIndentation,accountName).
	anOrderedCollection addAll: ((AccountReporter for: self) accountSummaryWithIndentation: (accordingIndentation,'#')).! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'ip 11/17/2022 19:47:30'!
name
	^accountName ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'ip 11/17/2022 19:52:21'!
nameWithIndetation: accordingIndentation on: anOrderedCollection
	 anOrderedCollection add: (accordingIndentation,accountName).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'ip 11/17/2022 12:49:55'!
named: aName
	^((ReceptiveAccount new) intializeNamed: aName).! !


!classDefinition: #AccountReporter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: 'associatedAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReporter methodsFor: 'instance creation' stamp: 'ip 11/15/2022 21:04:20'!
initializeFor: aReceptiveAccount 

	associatedAccount := aReceptiveAccount.! !


!AccountReporter methodsFor: 'main protocol' stamp: 'ip 11/17/2022 11:31:47'!
accountSummary
	|knownTransactions|
	(associatedAccount isKindOf: Account) ifFalse: [^self error: AccountReporter InvalidAccountAssigned].
	knownTransactions _ OrderedCollection with: ('Balance = ', associatedAccount balance asString ).
	(associatedAccount transactions) reverseDo: [ :aTransaction | knownTransactions addFirst: ( aTransaction reportDescription , aTransaction value asString)]  .
	^knownTransactions .! !

!AccountReporter methodsFor: 'main protocol' stamp: 'ip 11/17/2022 21:00:37'!
accountSummaryWithIndentation: accordingIndentation
	|knownTransactions|
	(associatedAccount isKindOf: Account) ifFalse: [^self error: AccountReporter InvalidAccountAssigned].
	knownTransactions _ OrderedCollection with: (accordingIndentation ,'Balance = ', associatedAccount balance asString ).
	(associatedAccount transactions) reverseDo: [ :aTransaction | knownTransactions addFirst: ( accordingIndentation , aTransaction reportDescription , aTransaction value asString)] .
	^knownTransactions .! !

!AccountReporter methodsFor: 'main protocol' stamp: 'ip 11/17/2022 12:33:08'!
netTransferReport
	| totalSum |
	(associatedAccount isKindOf: Account) ifFalse: [	^self error: AccountReporter InvalidAccountAssigned].
	totalSum _ ((associatedAccount transactions) sum: [ :aTransaction | aTransaction transferBalanceValue] ifEmpty: [0 * peso]).
	^'Net Transfer Balance = ', totalSum asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'ServiciosFinancieros-Solucion'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'ip 11/15/2022 21:02:52'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount ! !


!AccountReporter class methodsFor: 'Error Messages' stamp: 'ip 11/17/2022 11:32:05'!
InvalidAccountAssigned
	^'No puedo generar este reporte'! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'ip 11/17/2022 11:12:08'!
reportDescription
	self subclassResponsibility .! !

!AccountTransaction methodsFor: 'private' stamp: 'ip 11/17/2022 12:38:43'!
transferBalanceValue
	self subclassResponsibility .! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'private' stamp: 'ip 11/17/2022 11:11:32'!
reportDescription
	^'Depósito por '! !

!Deposit methodsFor: 'private' stamp: 'ip 11/17/2022 12:31:58'!
transferBalanceValue
	^0 * peso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'private' stamp: 'ip 11/17/2022 11:13:28'!
reportDescription
	^'Entrada por transferencia de '! !

!TransferDepositLeg methodsFor: 'private' stamp: 'ip 11/17/2022 12:34:38'!
transferBalanceValue
	^self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'private' stamp: 'ip 11/17/2022 11:10:58'!
reportDescription
	^'Salida por transferencia de '! !

!TransferWithdrawLeg methodsFor: 'private' stamp: 'ip 11/17/2022 12:32:39'!
transferBalanceValue
	^self value negated! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'private' stamp: 'ip 11/17/2022 11:11:41'!
reportDescription
	^'Extracción por '! !

!Withdraw methodsFor: 'private' stamp: 'ip 11/17/2022 12:32:10'!
transferBalanceValue
	^0 * peso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioReporter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioReporter
	instanceVariableNames: 'associatedPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioReporter methodsFor: 'initialization' stamp: 'ip 11/17/2022 19:15:54'!
initializeFor: aPortfolio

	associatedPortfolio := aPortfolio .! !


!PortfolioReporter methodsFor: 'main protocol' stamp: 'ip 11/17/2022 20:49:50'!
detailedTreePrinter
	|resultingCollection |
	resultingCollection _ OrderedCollection with: associatedPortfolio name.
	associatedPortfolio accounts do: [ :anAccount | anAccount detailedNameWithIndetation: ('#') on: resultingCollection ].
	resultingCollection add: '#Balance = ', (associatedPortfolio balance asString ).
	^resultingCollection .
	! !

!PortfolioReporter methodsFor: 'main protocol' stamp: 'ip 11/17/2022 20:18:17'!
treePrinter
 	|resultingCollection |
	resultingCollection _ OrderedCollection with: associatedPortfolio name.
	associatedPortfolio accounts do: [ :anAccount | anAccount nameWithIndetation: ('#') on: resultingCollection ].
	^resultingCollection .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReporter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioReporter class
	instanceVariableNames: ''!

!PortfolioReporter class methodsFor: 'instance creation' stamp: 'ip 11/17/2022 19:14:55'!
for: aPortfolio
	^self new initializeFor: aPortfolio ! !


!PortfolioReporter class methodsFor: 'as yet unclassified' stamp: 'ip 11/17/2022 19:24:47'!
indentation
	"Para simbolizar la indentacion vamos a usar un # por cada indentacion"
	^'#'! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
