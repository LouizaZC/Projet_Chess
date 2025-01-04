Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'accessing' }
MyKnightTest >> method [
 | knight |
	
knight := MyKnight new.
knight color: Color black.
self assert: knight color = Color black
]

{ #category : 'tests' }
MyKnightTest >> testIsBlackKnight [
	

	self assert: MyKnight black color = Color black


]

{ #category : 'tests' }
MyKnightTest >> testIsWhiteKnight [
	self assert: ((MyKnight white)color = Color white)
]

{ #category : 'tests' }
MyKnightTest >> testKnightId [
	self assert: MyKnight new id equals: 'N'
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnight [

| blackKnight|

    blackKnight := MyKnight new color: Color black.

    self assert: (MyWhiteSquare new renderKnight: blackKnight) equals: 'M'.

    self assert: (MyBlackSquare new renderKnight: blackKnight) equals: 'm'.
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnightBlacksquare [

	self
		assert: (MyBlackSquare new renderKnight: MyKnight black)
		equals: 'm'
]

{ #category : 'tests' }
MyKnightTest >> testRenderBlackKnightWhitesquare [

	self
		assert: (MyWhiteSquare new renderKnight: MyKnight black)
		equals: 'M'
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnight [

| whiteKnight|

  whiteKnight := MyKnight new color: Color white.

    self assert: (MyWhiteSquare new renderKnight: whiteKnight) equals: 'N'.

    self assert: (MyBlackSquare new renderKnight: whiteKnight) equals: 'n'.
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightBWhitesquare [

	self
		assert: (MyWhiteSquare new renderKnight: MyKnight white)
		equals: 'N'
]

{ #category : 'tests' }
MyKnightTest >> testRenderWhiteKnightBlacksquare [

	self
		assert: (MyBlackSquare new renderKnight: MyKnight white)
		equals: 'n'
]
