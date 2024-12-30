Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testRenderBlackQueen [

| blackQueen |

    blackQueen := MyQueen new color: Color black.

    self assert: (MyWhiteSquare new renderQueen: blackQueen) equals: 'W'.

    self assert: (MyBlackSquare new renderQueen: blackQueen) equals: 'w'.
]

{ #category : 'tests' }
MyQueenTest >> testRenderWhiteQueen [

	| whiteQueen |
	whiteQueen := MyQueen new color: Color white.

	self assert: (MyWhiteSquare new renderQueen: whiteQueen) equals: 'Q'.

	self assert: (MyBlackSquare new renderQueen: whiteQueen) equals: 'q'
]
