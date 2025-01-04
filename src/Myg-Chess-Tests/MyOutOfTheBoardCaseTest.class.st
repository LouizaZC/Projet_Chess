Class {
	#name : 'MyOutOfTheBoardCaseTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testAllMovementsReturnSelf [ 
	| square |
	square := MyOutOfTheBoardCase new.
	self assert: (square up) equals: square.
	self assert: (square down) equals: square.
	self assert: (square left) equals: square.
	self assert: (square right) equals: square
]

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testFile [  
	| square |
	square := MyOutOfTheBoardCase new.
	self assert: square file equals: -1 
]

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testHasNoPiece [ 
	| square |
	square := MyOutOfTheBoardCase new.
	self assert: square hasPiece equals: false
]

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testIsNotOutOfTheBoard [
	| square |
	square := MyChessSquare new.
	self deny: square isOutOftheBoard 
]

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testIsOutOfTheBoard [
	| square |
	square := MyOutOfTheBoardCase new.
	self assert: square isOutOftheBoard 
]

{ #category : 'tests' }
MyOutOfTheBoardCaseTest >> testUpReturnsSelf [ 
	| square |
	square := MyOutOfTheBoardCase new.
	self assert: (square up) equals: square.

]
