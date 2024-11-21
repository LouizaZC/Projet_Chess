Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testRenderBlackKnightBlacksquare [
	self assert: ((MyChessSquare black) renderKnight: (MyKnight black)) equals: 'm'
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderBlackKnightWhiteSquare [
	self assert: ((MyChessSquare white) renderKnight: (MyKnight black)) equals: 'M'
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderWhiteKnightBlackSquare [
	self assert: ((MyChessSquare black) renderKnight: (MyKnight white)) equals: 'n' 
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderWhiteKnightWhiteSquare [
	self assert: ((MyChessSquare white) renderKnight: (MyKnight white)) equals: 'N' 
]
