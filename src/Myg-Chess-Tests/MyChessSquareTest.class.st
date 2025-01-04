Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testRenderBlackKnightBlacksquare [

	"self
		assert: (MyChessSquare black renderKnight: MyKnight black)
		equals: 'm'  "
		
	self
		assert: (MyBlackSquare new renderKnight: MyKnight black)
		equals: 'm'
	
	
	
	"MyKnight new color: Color black.
| blackKnight |
	blackKnight := MyKnight new color: Color black.

	self
		assert: (MyWhiteSquare new renderKnight: blackKnight)
		equals: 'M'.

	self
		assert: (MyBlackSquare new renderKnight: blackKnight)
		equals: 'm' "
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderBlackKnightWhitesquare [

	self
		assert: (MyWhiteSquare new renderKnight: MyKnight black)
		equals: 'M'
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderWhiteKnightBlacksquare [

	self
		assert: (MyBlackSquare new renderKnight: MyKnight white)
		equals: 'n'
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderWhiteKnightWhitesquare [

	self
		assert: (MyWhiteSquare new renderKnight: MyKnight white)
		equals: 'N'
]
