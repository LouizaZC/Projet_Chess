Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testHasPiece [
	|board square piece|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a7'.
	piece := MyPiece new .
	square contents: piece .
	square hasPiece .
	self assert: square hasPiece equals: piece.
]

{ #category : 'tests' }
MyChessSquareTest >> testNoNilChecks [
	|board piece square |
	board := MyChessBoard empty.
	piece := MyPawn white.
	square := MyChessSquare new.
	square := board at: 'd3'.
	square contents: piece.
	square emptyContents.
	self assert: (square contents isKindOf: MyVoidPiece).
	
]

{ #category : 'tests' }
MyChessSquareTest >> testPlacePiece [
    | square piece |
    square := MyChessSquare new.
    piece := MyPawn new. 
    
    self assert: (square put: piece) equals: piece.
    square put: nil.
 
    self assert: square piece isNil. 
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderBlackKnightBlacksquare [

	"self
		assert: (MyChessSquare black renderKnight: MyKnight black)
		equals: 'm'"
]

{ #category : 'tests' }
MyChessSquareTest >> testSetAName [
    | square |
    square := MyChessSquare new.
	 square color: Color white.
    square name: 'a7'.
    self assert: square name equals: 'a7'.
]

{ #category : 'tests' }
MyChessSquareTest >> testSetColor [ 
	| square|
	square := MyChessSquare new.
		square color: Color black.
		self assert: square color equals: Color black.
]
