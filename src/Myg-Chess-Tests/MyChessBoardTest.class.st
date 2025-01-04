Class {
	#name : 'MyChessBoardTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessBoardTest >> testAtTheBoard [ 
    | board |
    board := MyChessBoard empty.

    self deny: (board at: 'b2') isOutOftheBoard 
]

{ #category : 'tests' }
MyChessBoardTest >> testHighLightTargets [
    | board squares |
    board := MyChessBoard empty.
    squares := { (board at: 'b2'). (board at: 'b5'). (board at: 'c6') }.
    board highLightTargets: squares.
    self assert: squares size equals: 3  
]

{ #category : 'tests' }
MyChessBoardTest >> testHighLightTargetsFalse [ 
    | board squares |
    board := MyChessBoard empty.
    squares := { (board at: 'b2'). (board at: 'b11') }.
    board highLightTargets: squares.
    self assert: squares notEmpty
]

{ #category : 'tests' }
MyChessBoardTest >> testOutOfTheBoard [ 
    | board |
    board := MyChessBoard empty.

    self assert: (board at: 'b11') isOutOftheBoard 
]

{ #category : 'tests' }
MyChessBoardTest >> testUnhighLightTargetsFalse [
    |board outOfBoard result |
    board := MyChessBoard empty.
    outOfBoard := board at: 'a12'.
    result := [ board unhighLightTargets: { outOfBoard } ].
    self assert: result isBlock
]
