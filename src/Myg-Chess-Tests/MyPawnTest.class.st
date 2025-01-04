Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testId [

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testIsBlackPawn [

	self assert: MyPawn black color = Color black
]

{ #category : 'tests' }
MyPawnTest >> testIsWhitePawn [

	self assert: MyPawn white color = Color white
]

{ #category : 'tests' }
MyPawnTest >> testRenderBlackPawnBlacksquare [

	self assert: (MyBlackSquare new renderPawn: MyPawn black) equals: 'o'
]

{ #category : 'tests' }
MyPawnTest >> testRenderBlackPawnWhitesquare [

	self assert: (MyWhiteSquare new renderPawn: MyPawn black) equals: 'O'
]

{ #category : 'tests' }
MyPawnTest >> testRenderWhitePawnBlacksquare [

	self assert: (MyBlackSquare new renderPawn: MyPawn white) equals: 'p'
]

{ #category : 'tests' }
MyPawnTest >> testRenderWhitePawnWhitesquare [

	self assert: (MyWhiteSquare new renderPawn: MyPawn white) equals: 'P'
]
