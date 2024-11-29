Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testRenderBlackPawn [

	| blackPawn |
	blackPawn := MyPawn new color: Color black.

	self assert: (MyWhiteSquare new renderPawn: blackPawn) equals: 'O'.

	self assert: (MyBlackSquare new renderPawn: blackPawn) equals: 'o'
]

{ #category : 'tests' }
MyPawnTest >> testRenderWhitePawn [

	| whitePawn|
	whitePawn := MyPawn new color: Color white.

	self assert: (MyWhiteSquare new renderPawn: whitePawn) equals: 'P'.

	self assert: (MyBlackSquare new renderPawn: whitePawn) equals: 'p'
]
