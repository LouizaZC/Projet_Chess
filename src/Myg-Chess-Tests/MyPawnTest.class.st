Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testBasicMove [ 

	| game pawn startSquare targetSquare |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	startSquare := pawn square.
	targetSquare := pawn singleStepSquare.

	
	game move: pawn to: targetSquare.
	self assert: pawn square equals: targetSquare.
	self deny: startSquare hasPiece.

]

{ #category : 'tests' }
MyPawnTest >> testCaptureBlocked [ 
	| game pawn opponentPawn blockingPiece legalMoves |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	opponentPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].

	
	game move: opponentPawn to: opponentPawn square down down.
	blockingPiece := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
	game move: blockingPiece to: opponentPawn square.

	legalMoves := pawn calculateCaptureMoves.
	self deny: (legalMoves includes: opponentPawn square).
]

{ #category : 'tests' }
MyPawnTest >> testEdgeOfBoardMove [ 
	| game pawn legalMoves |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'a2' ] ].

	legalMoves := pawn basicMovesLegal.
	self deny: (legalMoves includes: pawn square + (-1 @ pawn forwardDirection)).

]

{ #category : 'tests' }
MyPawnTest >> testEnPassantFailsAfterOtherMove [ 
	| game whitePawn blackPawn thirdPiece startSquare enPassantSquare |
	game := MyChessGame freshGame.

	
	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].
	thirdPiece := game pieces detect: [ :p | p isPawn and: [ p square name = 'g7' ] ].

	game move: whitePawn to: whitePawn square up up.
	game move: whitePawn to: whitePawn square up.
	startSquare := whitePawn square.


	game move: blackPawn to: blackPawn square down down.
	enPassantSquare := blackPawn square up.
	game move: thirdPiece to: thirdPiece square down down.
	game move: whitePawn to: enPassantSquare.
	
	self assert: whitePawn square equals: startSquare. 
	self assert: blackPawn square hasPiece. 
	self assert: (whitePawn calculateEnPassant isEmpty). 
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantNotAvailable [ 
	| game whitePawn blackPawn invalidSquare startSquare |
	game := MyChessGame freshGame.

	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'g7' ] ].


	game move: whitePawn to: whitePawn square up up.
	game move: whitePawn to: whitePawn square up.
	startSquare := whitePawn square.


	game move: blackPawn to: blackPawn square down down.
	invalidSquare := blackPawn square up.


	game move: whitePawn to: invalidSquare.

	self assert: whitePawn square equals: startSquare. 
	self assert: blackPawn square hasPiece.
	self assert: (whitePawn calculateEnPassant isEmpty).
]

{ #category : 'tests' }
MyPawnTest >> testFirstMoveFlag [ 
	| game pawn |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].

	self assert: pawn firstMove.

	game move: pawn to: pawn singleStepSquare.

	self deny: pawn firstMove.


]

{ #category : 'tests' }
MyPawnTest >> testForwardDirection [ 
	| game pawn |
	game := MyChessGame freshGame.

	pawn := game pieces detect: [ :p | p isPawn and: [ p color = Color white ] ].
	self assert: (pawn forwardDirection = 1).

	pawn := game pieces detect: [ :p | p isPawn and: [ p color = Color black ] ].
	self assert: (pawn forwardDirection = -1).
]

{ #category : 'tests' }
MyPawnTest >> testInitialDoubleMove [ 
	| game pawn startSquare doubleStepSquare |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	startSquare := pawn square.
	doubleStepSquare := pawn doubleStepSquare.

	game move: pawn to: doubleStepSquare.
	self assert: pawn square equals: doubleStepSquare.
	self deny: startSquare hasPiece.
]

{ #category : 'tests' }
MyPawnTest >> testInitialSingleMove [ 
	| game pawn startPosition nextPosition |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].

	
	startPosition := pawn square.
	nextPosition := startPosition up.
	game move: pawn to: nextPosition.
	
	self assert: pawn square equals: nextPosition.
	self deny: startPosition hasPiece.



]

{ #category : 'tests' }
MyPawnTest >> testMoveAfterInitialMove [ 
	| game pawn initialPosition nextPosition invalidDoubleStep |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].


	initialPosition := pawn square.
	nextPosition := initialPosition up up.
	game move: pawn to: nextPosition.
	self assert: pawn square equals: nextPosition.
	self deny: initialPosition hasPiece.

	invalidDoubleStep := nextPosition up up.
	game move: pawn to: invalidDoubleStep.
	self deny: pawn square equals: invalidDoubleStep. 
	self assert: pawn square equals: nextPosition. 


	nextPosition := nextPosition up.
	game move: pawn to: nextPosition.
	self assert: pawn square equals: nextPosition.
	self deny: initialPosition hasPiece.

]

{ #category : 'tests' }
MyPawnTest >> testPawnBlockedByAlly [ 
	| game whitePawn allyPawn startSquare blockedSquare |
	game := MyChessGame freshGame.

	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	allyPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd2' ] ].

	startSquare := whitePawn square.
	blockedSquare := allyPawn square.

	game move: whitePawn to: blockedSquare.
	self assert: whitePawn square equals: startSquare.
	self assert: blockedSquare contents equals: allyPawn. 
]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotMoveBackwards [ 
   | game pawn invalidPosition |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].

	invalidPosition := pawn square left.
	game move: pawn to: invalidPosition.
	self assert: pawn square name equals: 'e2'.

	invalidPosition := pawn square down.
	game move: pawn to: invalidPosition.
	self assert: pawn square name equals: 'e2'. 




]

{ #category : 'tests' }
MyPawnTest >> testRenderPieceOn [ 
	| game pawn targetSquare |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	targetSquare := pawn square.
	
	self shouldnt: [ pawn renderPieceOn: targetSquare ] raise: Error.


]

{ #category : 'tests' }
MyPawnTest >> testValidEnPassantCapture [ 
	| game whitePawn blackPawn initialSquare enPassantSquare |
	game := MyChessGame freshGame.

	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].

	game move: whitePawn to: whitePawn square up up.
	game move: whitePawn to: whitePawn square up.
	initialSquare := whitePawn square.

	game move: blackPawn to: blackPawn square down down.
	enPassantSquare := blackPawn square up. 
	
	self assert: (whitePawn calculateEnPassant includes: enPassantSquare).

	game move: whitePawn to: enPassantSquare.

	self assert: whitePawn square equals: enPassantSquare.
	self deny: initialSquare hasPiece. 
	self deny: blackPawn square hasPiece.

]
