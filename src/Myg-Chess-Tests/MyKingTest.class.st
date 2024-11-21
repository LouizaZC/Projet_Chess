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
MyKingTest >> testRenderBlackKing [

| blackKing |

    blackKing := MyKing new color: Color black.

    self assert: (MyWhiteSquare new renderKing: blackKing) equals: 'L'.

    self assert: (MyBlackSquare new renderKing: blackKing) equals: 'l'.
]

{ #category : 'tests' }
MyKingTest >> testRenderWhiteKing [

| whiteKing |

   whiteKing := MyKing new color: Color white.

    self assert: (MyWhiteSquare new renderKing: whiteKing) equals: 'K'.

    self assert: (MyBlackSquare new renderKing: whiteKing) equals: 'k'.
]
