Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testEmptyContents [
	|board piece square|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a5'.
	piece := MyPawn black .
	square contents: piece .
	square emptyContents .

	self deny: square contents equals: nil.
]

{ #category : 'tests' }
MyChessSquareTest >> testEmptyContentsWithoutTheNilChecks [

	|board piece square|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'b6'.
	piece := MyPawn white .
	square contents: piece .
	square emptyContents .

	self assert: (square contents isKindOf: MyVoidPiece ).
]

{ #category : 'tests' }
MyChessSquareTest >> testHasPiece [
	|board square piece|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a5'.
	square name: 'a5'.
	square color: Color black.
	piece := MyPiece new .
	piece := MyPawn white .
	square contents: piece .

	self assert: square contents equals: piece.
]

{ #category : 'tests' }
MyChessSquareTest >> testHasPieceNoNilChecks [
	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a5'.
	piece := MyPawn white .
	square contents: piece .
	square hasPiece .

	self assert: square hasPiece equals: piece isVoidPiece not.
]

{ #category : 'tests' }
MyChessSquareTest >> testHasPieceWithoutNilChecks [
	|board piece square|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a5'.
	piece := MyPawn black .
	square contents: piece .
	square hasPiece .

	self assert: square hasPiece equals: piece isVoidPiece not.
]

{ #category : 'tests' }
MyChessSquareTest >> testInitSquareIsEmpty [ 
    | chessSquare |
	 chessSquare := MyChessSquare new.
    self assert: chessSquare hasPiece equals: false.
    
    
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

{ #category : 'tests' }
MyChessSquareTest >> testSetPiece [
	|board square piece|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'a5'.
	square name: 'a5'.
	square color: Color black.
	piece := MyPiece new .
	piece := MyPawn white .
	square contents: piece .

	self assert: square contents equals: piece.
]

{ #category : 'tests' }
MyChessSquareTest >> testSquareNameSetter [ 
    | square |
    square := MyChessSquare new.
	 square color: Color black.
    square name: 'a5'.

    self assert: square name equals: 'a5'.
]
