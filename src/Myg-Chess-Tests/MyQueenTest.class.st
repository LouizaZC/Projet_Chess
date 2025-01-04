Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testId [

	self assert: MyQueen new id equals: 'Q'
]

{ #category : 'tests' }
MyQueenTest >> testIsBlackQueen [

	self assert: MyQueen black color = Color black
]

{ #category : 'tests' }
MyQueenTest >> testIsWhiteQueen [

	self assert: MyQueen white color = Color white
]

{ #category : 'tests' }
MyQueenTest >> testRenderBlackQueenBlacksquare [

	self
		assert: (MyBlackSquare new renderQueen: MyQueen black)
		equals: 'w'
]

{ #category : 'tests' }
MyQueenTest >> testRenderBlackQueenWhitesquare [

	self
		assert: (MyWhiteSquare new renderQueen: MyQueen black)
		equals: 'W'
]

{ #category : 'tests' }
MyQueenTest >> testRenderWhiteQueenBlacksquare [

	self
		assert: (MyBlackSquare new renderQueen: MyQueen white)
		equals: 'q'
]

{ #category : 'tests' }
MyQueenTest >> testRenderWhiteQueenWhitesquare [

	self
		assert: (MyWhiteSquare new renderQueen: MyQueen white)
		equals: 'Q'
]
