Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testIsBlackAndIsWhite [ 
    | blackPawn whitePawn |
    
    blackPawn := MyPawn black.
    whitePawn := MyPawn white.
    
    self assert: blackPawn isBlack.
    self assert: whitePawn isWhite.
]

{ #category : 'tests' }
MyPawnTest >> testMoveToOneSquare [ 
    | pawn board |
    
    pawn := MyPawn black.
    board := MyChessBoard empty .
    

    board at: 'e2' put: pawn.
    
    self assert: pawn move equals: true.
 

]

{ #category : 'tests' }
MyPawnTest >> testPawnId [
	| pawn |
    pawn := MyPawn new.
    self assert: (pawn id = 'P').

]
