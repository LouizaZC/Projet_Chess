Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testRenderBishopWhitePieceBlackColor [ 
    | bishopPiece renderer |
    
    bishopPiece := MyBishop new.
    bishopPiece color: Color black .
    
    renderer := MyChessSquare new.
	 renderer color: Color black .
    self assert: (renderer renderBishop: bishopPiece) equals: 'v'.

	 renderer color: Color white .
	 self assert: (renderer renderBishop: bishopPiece) equals: 'V'.
	
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderBishopWhitePieceWhiteColor [ 
    | bishopPiece renderer |
    
    bishopPiece := MyBishop new.
    bishopPiece color: Color white .
    
    renderer := MyChessSquare new.
	 renderer color: Color black .
    self assert: (renderer renderBishop: bishopPiece) equals: 'b'.

	 renderer color: Color white .
	 self assert: (renderer renderBishop: bishopPiece) equals: 'B'.
	
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKingBlackPieceBlackColor [ 
    | kingPiece renderer |
    
    kingPiece := MyKing new.
    kingPiece color: Color black.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderKing: kingPiece) equals: 'l'.


]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKingBlackPieceWhiteColor [ 
    | kingPiece renderer |
    
    kingPiece := MyKing new.
    kingPiece color: Color black.
    
    renderer := MyChessSquare new.
    
    renderer color: Color white.
    self assert: (renderer renderKing: kingPiece) equals: 'L'.

]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKingWhitePieceBlackColor [ 
    | kingPiece renderer |
    
    kingPiece := MyKing new.
    kingPiece color: Color white .
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderKing: kingPiece) equals: 'k'.


]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKingWhitePieceWhiteColor [ 
    | kingPiece renderer |
    
    kingPiece := MyKing new.
    kingPiece color: Color white .
    
    renderer := MyChessSquare new.
    renderer color: Color white .
    self assert: (renderer renderKing: kingPiece) equals: 'K'.


]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKnightBlackPieceBlackColor [ 
    | knightPiece renderer |
    
    knightPiece := MyKnight new.
    knightPiece color: Color black.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderKnight: knightPiece) equals: 'm'.
   
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKnightBlackPieceWhiteColor [ 
    | knightPiece renderer |
    
    knightPiece := MyKnight new.
    knightPiece color: Color black.
    
    renderer := MyChessSquare new.
 
    
    renderer color: Color white.
    self assert: (renderer renderKnight: knightPiece) equals: 'M'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKnightWhitePieceBlackColor [ 
    | knightPiece renderer |
    
    knightPiece := MyKnight new.
    knightPiece color: Color white.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderKnight: knightPiece) equals: 'n'.
   
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderKnightWhitePieceWhiteColor [ 
    | knightPiece renderer |
    
    knightPiece := MyKnight new.
    knightPiece color: Color white.
    
    renderer := MyChessSquare new.
    
    renderer color: Color white.
    self assert: (renderer renderKnight: knightPiece) equals: 'N'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderPawnBlackPieceBlackColor [ 
    | pawnPiece renderer |
    
    pawnPiece := MyPawn new.
    pawnPiece color: Color black.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderPawn: pawnPiece) equals: 'o'.
   

]

{ #category : 'tests' }
MyChessSquareTest >> testRenderPawnBlackPieceWhiteColor [ 
    | pawnPiece renderer |
    
    pawnPiece := MyPawn new.
    pawnPiece color: Color black.
    
    renderer := MyChessSquare new.
    
    renderer color: Color white.
    self assert: (renderer renderPawn: pawnPiece) equals: 'O'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderPawnWhitePieceBlackColor [ 
    | pawnPiece renderer |
    
    pawnPiece := MyPawn new.
    pawnPiece color: Color white.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderPawn: pawnPiece) equals: 'p'.
   
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderPawnWhitePieceWhiteColor [ 
    | pawnPiece renderer |
    
    pawnPiece := MyPawn new.
    pawnPiece color: Color white.
    
    renderer := MyChessSquare new.
    
    renderer color: Color white.
    self assert: (renderer renderPawn: pawnPiece) equals: 'P'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderQueenBlackPieceBlackColor [ 
    | queenPiece renderer |
    
    queenPiece := MyQueen new.
    queenPiece color: Color black.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderQueen: queenPiece) equals: 'w'.
 
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderQueenBlackPieceWhiteColor [ 
    | queenPiece renderer |
    
    queenPiece := MyQueen new.
    queenPiece color: Color black.
    
    renderer := MyChessSquare new.
    
    
    renderer color: Color white.
    self assert: (renderer renderQueen: queenPiece) equals: 'W'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderQueenWhitePieceBlackColor [ 
    | queenPiece renderer |
    
    queenPiece := MyQueen new.
    queenPiece color: Color white.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderQueen: queenPiece) equals: 'q'.

]

{ #category : 'tests' }
MyChessSquareTest >> testRenderQueenWhitePieceWhiteColor [ 
    | queenPiece renderer |
    
    queenPiece := MyQueen new.
    queenPiece color: Color white.
    
    renderer := MyChessSquare new.
  
    
    renderer color: Color white.
    self assert: (renderer renderQueen: queenPiece) equals: 'Q'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderRookBlackPieceBlackColor [ 
    | rookPiece renderer |
    
    rookPiece := MyRook new.
    rookPiece color: Color black.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderRook: rookPiece) equals: 't'.
    

]

{ #category : 'tests' }
MyChessSquareTest >> testRenderRookBlackPieceWhiteColor [ 
    | rookPiece renderer |
    
    rookPiece := MyRook new.
    rookPiece color: Color black.
    
    renderer := MyChessSquare new.
   
    
    renderer color: Color white.
    self assert: (renderer renderRook: rookPiece) equals: 'T'.
]

{ #category : 'tests' }
MyChessSquareTest >> testRenderRookWhitePieceBlackColor [ 
    | rookPiece renderer |
    
    rookPiece := MyRook new.
    rookPiece color: Color white.
    
    renderer := MyChessSquare new.
    renderer color: Color black.
    self assert: (renderer renderRook: rookPiece) equals: 'r'.

]

{ #category : 'tests' }
MyChessSquareTest >> testRenderRookWhitePieceWhiteColor [ 
    | rookPiece renderer |
    
    rookPiece := MyRook new.
    rookPiece color: Color white.
    
    renderer := MyChessSquare new.
    
    
    renderer color: Color white.
    self assert: (renderer renderRook: rookPiece) equals: 'R'.
]
