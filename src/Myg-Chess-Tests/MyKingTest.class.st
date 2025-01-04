Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testId [
self assert: MyKing new id equals: 'K'
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testRenderBlackKingBlacksquare [

	self
		assert: (MyBlackSquare new renderKing: MyKnight black)
		equals: 'l'
]

{ #category : 'tests' }
MyKingTest >> testRenderBlackKingWhitesquare [

	self
		assert: (MyWhiteSquare new renderKing: MyKnight black)
		equals: 'L'
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingBlacksquare [

	self assert: (MyBlackSquare new renderKing: MyKing white) equals: 'k'
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKingWhitesquare [

	self assert: (MyWhiteSquare new renderKing: MyKing white) equals: 'K'
]
